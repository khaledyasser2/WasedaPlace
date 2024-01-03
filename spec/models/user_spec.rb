require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :name}
  it { should allow_value("asdf@gmail.com").for(:email)}
  it { should validate_presence_of :password}

  it "should have a valid factory" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "should not have case sensitive email" do
    user1=FactoryBot.create(:user, email: "abc@gmail.com")
    user2=FactoryBot.create(:user, email: "ABC@GMAIl.Com")

    expect(user2).to_not be_valid

  end
end
