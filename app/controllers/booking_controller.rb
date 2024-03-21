class BookingController < ApplicationController
  
  
  def index
    # file_path = Rails.root.join('public', 'data', 'ART.json')
    # class_schedules = JSON.parse(File.read(file_path))
    class_schedules=read_all_json_from_directory(Rails.root.join('public', 'data'))
    @available_slots = process_schedules_for_availability(class_schedules)
  end

private

  def process_schedules_for_availability(schedules)
    parsed = schedules.map { |s| {name: s["b"], day: s["i"][0]&.dig("d"), period: s["i"][0]&.dig("p"), room: s["i"][0]&.dig("l") } }
    days=[-1] + (1..6).to_a
    periods=(1..7).to_a
    buildings=["51","52","53","54","55","56","57","58","59","60","61","62","63","65","66"]
    
    rooms=[101, 102, 103, 104, 201, 202, 203, 204, 301, 302, 303, 304, 401, 402, 403, 404]
    
    locations = buildings.product(rooms).map { |b, r| "#{b}-#{r}" }
    combinations = days.product(periods, locations).map do |day, period, location|
      { day: day, period: period, location: location }
    end

    # available = combinations.select do |combo|
    #   parsed.none? { |course| course[:day] == combo[:day] && course[:period] == combo[:period] && course[:location] == combo[:location] }
    # end
    # debugger
    #
    # return available
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
