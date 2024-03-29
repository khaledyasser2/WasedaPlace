require 'rails_helper'

RSpec.describe "AccountManagements", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  feature "registration" do
    scenario "user registers account with valid info" do
      n_users = User.count
      visit root_path
      click_on "Sign up now!"

      fill_in "Name", with: "jojo"
      fill_in "Email", with: "jojo@gmail.com"
      fill_in "Password", with: "jojomojo"
      fill_in "Password confirmation", with: "jojomojo"
      
      click_on "Create my account"

      new_user=User.last
      token=User.new_token
      digest=User.digest(token)
      
      new_user.activation_token=token
      new_user.update_columns(activation_digest: digest)
      
      aggregate_failures do
        expect(User.count).to equal n_users+1
        expect(new_user[:name]).to eq "jojo"
        expect(new_user[:password]).to eq nil #since it's obscured
        expect(new_user[:password_confirmation]).to eq nil
        expect(new_user[:activated]).to eq false
        expect(new_user.authenticated?(:activation, "")).to eq false
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries.last.to).to eq([User.last.email])
      end
      #testing redirect
      expect(page).to have_current_path root_path
      
      visit edit_account_activation_url(new_user.activation_token, email: new_user.email, only_path: true)
      expect(page).to have_current_path user_path(new_user)
    end

    scenario "user registers account with invalid info" do
      n_users = User.count
      visit root_path
      click_on "Sign up now!"

      fill_in "Name", with: "jojo"
      fill_in "Email", with: "jojo"
      fill_in "Password", with: "asd"
      fill_in "Password confirmation", with: "asdf"
      click_on "Create my account"
      
      expect(page).to have_selector("div", class:"field_with_errors")

      fill_in "Email", with: "jojo@gmail.com"
      click_on "Create my account"

      expect(page).to have_current_path users_path
      
      fill_in "Password", with: "asd"
      fill_in "Password confirmation", with: "asd"
      click_on "Create my account"
      
      expect(page).to have_current_path users_path
    end
  end

  feature "logging in" do
    let(:user) { FactoryBot.create(:user) }
    
    scenario "login attempt with right credentials" do
      visit root_path
      click_on "Log in"

      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_on "Log in", id: "user_login"

      aggregate_failures do
        expect(page).to have_current_path user_path(user)
      end
    end

    scenario "login attempt with wrong credentials" do
      visit root_path
      click_on "Log in"

      fill_in "Email", with: "example@gmail.com"
      fill_in "Password", with: "wrongpassword"
      click_on "Log in", id: "user_login"

      aggregate_failures do
        expect(page).to have_current_path login_path
        expect(page).to have_selector("div", class:"alert alert-danger")
        expect(page).to have_text("Invalid email/password combination")
      end
    end

    scenario "Not using remember me" do
      visit root_path
      click_on "Log in"
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      #check "session_remember_me"
      click_on "Log in", id: "user_login"
      Capybara.reset_sessions!
      visit root_path
      expect(page).to have_current_path root_path
    end
    
    scenario "Using remember me" do
      visit root_path
      click_on "Log in"
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      check "session_remember_me"
      click_on "Log in", id: "user_login"
      Capybara.reset_sessions!
      visit root_path
      expect(page).to have_current_path user_path(user)
    end
  end
end
