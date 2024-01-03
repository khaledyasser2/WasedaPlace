require 'rails_helper'

RSpec.describe "AccountManagements", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  scenario "user registers account" do
    n_users = User.count
    visit root_path
    click_on "Sign up now!"

    fill_in "Name", with: "jojo"
    fill_in "Email", with: "jojo@gmail.com"
    fill_in "Password", with: "jojomojo"
    fill_in "Password confirmation", with: "jojomojo"
    
    click_on "Create my account"

    aggregate_failures do
      expect(User.count).to equal n_users+1
      expect(User.last[:name]).to eq "jojo"
      expect(User.last[:password]).to eq nil #since it's obscured
      expect(User.last[:password_confirmation]).to eq nil
    end

    #testing redirect
    expect(page).to have_current_path user_path(User.last)

  end
end
