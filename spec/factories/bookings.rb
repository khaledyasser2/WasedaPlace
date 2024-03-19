FactoryBot.define do

  sequence :booking_date do |n|
    Date.today + n.days
  end
  
  factory :booking do
    user
    date { generate(:booking_date) }
    room_number { rand(100..300).to_s }    
  end
  
end
