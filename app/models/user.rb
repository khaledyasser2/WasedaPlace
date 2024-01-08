class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true,
            length: {maximum:255}
  validates :name, presence: true, length: {maximum: 50}
  validates :password, length: {minimum:6}, presence:true, allow_nil: false
  has_secure_password

  before_save do
    self.email.downcase!
  end
end
