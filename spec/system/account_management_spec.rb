require 'rails_helper'

RSpec.describe "AccountManagements", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  scenario "user registers account" do
    visit root_path
    click_on "Sign up now!"
    
  end
end
