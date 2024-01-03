require 'rails_helper'

RSpec.describe "AccountManagements", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  scenario "user registers account" do
    visit root_path
    click_on "Sign up now!"

    fill_in "Name", with: "jojo"
    fill_in "Email", with: "jojo@gmail.com"
    fill_in "Password", with: "jojomojo"
    fill_in "Password confirmation", with: "jojomojo"
    
    click_on "Create my account"
  end
end
