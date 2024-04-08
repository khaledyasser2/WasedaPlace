class Booking < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :period, presence: true
  validates :room_number, presence: true

  validates :date, uniqueness: { scope: [:period, :room_number] }
  
end
