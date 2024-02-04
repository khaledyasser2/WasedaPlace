class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true,
            length: {maximum:255}
  validates :name, presence: true, length: {maximum: 50}
  validates :password, length: {minimum:6}, presence:true, allow_nil: false
  has_secure_password

  before_create :create_activation_digest

  before_save do
    self.email.downcase!
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) 
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
    remember_digest
  end
  
  def forget 
    update_attribute(:remember_digest, nil)
  end
  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def session_token
    remember_digest || remember
  end

  private
  
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
end
