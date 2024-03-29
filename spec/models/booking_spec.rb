require 'rails_helper'

RSpec.describe Booking, type: :model do
  it { should belong_to :user}
  # it { should allow_value("asdf@gmail.com").for(:email)}
  it { should validate_presence_of :date}
  it { should validate_presence_of :period}
  it { should validate_presence_of :room_number}

  it "should have a valid factory" do
    booking = FactoryBot.create(:booking)
    expect(booking).to be_valid
  end
end
