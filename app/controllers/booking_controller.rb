class BookingController < ApplicationController
  
  def index
    file_path = Rails.root.join('public', 'data', 'ART.json')
    class_schedules = JSON.parse(File.read(file_path))
    @available_slots = process_schedules_for_availability(class_schedules)
  end

private

  def process_schedules_for_availability(schedules)
    parsed = schedules.map { |s| {name: s["b"], day: s["i"][0]["d"], period: s["i"][0]["p"], room: s["I"][0]["l"] } }
    all=[]
  end
end
