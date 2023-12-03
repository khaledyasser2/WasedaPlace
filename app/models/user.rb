class User < ApplicationRecord
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  has_secure_password
end
