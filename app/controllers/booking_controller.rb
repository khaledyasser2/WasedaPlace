class BookingController < ApplicationController
  
  
  def index
    # file_path = Rails.root.join('public', 'data', 'ART.json')
    # class_schedules = JSON.parse(File.read(file_path))
    class_schedules=read_all_json_from_directory(Rails.root.join('public', 'data'))
    @available_slots = process_schedules_for_availability(class_schedules)
  end

private

  def process_schedules_for_availability(schedules)
  
    buildings=["51","52","53","54","55","56","57","58","59","60","61","62","63","65","66"]
    rooms=[101, 102, 103, 104, 201, 202, 203, 204, 301, 302, 303, 304, 401, 402, 403, 404]
    locations = buildings.product(rooms).map { |b, r| "#{b}-#{r}" }
    # p locations
    
    data = ([-1] + (1..6).to_a).each_with_object({}) do |day, hash|
      hash[day] = (1..8).each_with_object({}) do |location, inner_hash|
        inner_hash[location] = locations.each_with_object({}) { |location, deepest_hash| deepest_hash[location] = "x" }
      end
    end
    
    debugger
    # parsed = schedules.map { |s| {name: s["b"], day: s["i"][0]&.dig("d"), period: s["i"][0]&.dig("p"), room: s["i"][0]&.dig("l") } }
    # data = ([-1] + (1..6).to_a).map { |a| [a=>{}] }.flatten
    #
    # schedules.each do |s|
    # end
    # combinations = days.product(periods, locations).map do |day, period, location|
    #   { day: day, period: period, location: location }
    # end
  end

  def read_all_json_from_directory(directory_path)
    data_list = []
    Dir.glob("#{directory_path}/*.json") do |file_path|
      begin
        data_list << JSON.parse(File.read(file_path))
      rescue StandardError => e
        Rails.logger.error "Error reading JSON file #{file_path}: #{e.message}"
      end
    end
    data_list.flatten
  end
  
end
