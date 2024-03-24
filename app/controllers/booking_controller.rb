class BookingController < ApplicationController
  
  
  def index
    # file_path = Rails.root.join('public', 'data', 'ART.json')
    # class_schedules = JSON.parse(File.read(file_path))
    class_schedules=read_all_json_from_directory(Rails.root.join('public', 'data'))
    @available_slots = process_schedules_for_availability(class_schedules)
  end

private

  def process_schedules_for_availability(schedules)
    data = ([-1] + (1..6).to_a).each_with_object({}) do |day, hash|
      hash[day] = (1..7).each_with_object({}) do |location, inner_hash|
        inner_hash[location] ={} 
      end
    end

    dropped=0
    
    schedules.each do |s|
      begin
        data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")][s["i"][0]&.dig("l")] =s["b"]
      rescue
        begin
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")]={}
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")][s["i"][0]&.dig("l")] =s["b"]
        rescue
          dropped+=1
          p s
        end
      end
    end
    debugger 
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
