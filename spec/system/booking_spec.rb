require 'rails_helper'

RSpec.describe "BookingManagement", type: :system do
  before do
    driven_by(:rack_test)
  end

  before(:each) do
    Booking.delete_all
  end
  
  feature "booking" do
    let(:user) { FactoryBot.create(:user) }

    scenario "attempt to book without logging in" do
      visit booking_index_path
      post booking_index_path, params: { room: "", period: "", date: "" }
      expect(flash["alert"]).to include("You need to log in to book")
    end
    
    scenario "logged in user books valid time" do
      n_bookings=Booking.count
      visit root_path
      click_on "Log in"

      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_on "Log in", id: "user_login"
      
      visit booking_index_path
      select('Wednesday', from: 'date')
      select("1", from: "period")
      click_on "Submit"

      expect(page).to have_content("Available Rooms")

      within ".rooms" do
        first(:button, "book").click
      end
     
      expect(page).to have_content("Booking created successfully")
      expect(Booking.count).to eq n_bookings+1
    end
  end
end
