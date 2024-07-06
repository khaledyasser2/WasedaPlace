class Booking < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :period, presence: true
  validates :room_number, presence: true

  # this makes sure no 2 bookings are on the same day
  # validates :date, uniqueness: { scope: [:period, :room_number] }
  validate :validate_unique_booking

  private

    def validate_unique_booking
      # debugger
      if Booking.where(date: date, period: period, room_number: room_number, user_id: user_id).present?
        errors.add(:base, "You already booked this time!")
        # debugger
      elsif Booking.where(date: date, period: period, room_number: room_number, entire_room: true).present?
        errors.add(:base, "Someone else already booked this entire room")
      end
    end
end
