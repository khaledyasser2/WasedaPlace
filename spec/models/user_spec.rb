require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :name}
  it { should allow_value("asdf@gmail.com").for(:email)}
  it { should validate_presence_of :password}
  it { should validate_uniqueness_of(:email).case_insensitive}
end
