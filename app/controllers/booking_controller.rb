class BookingController < ApplicationController
  
  
  def index
    # file_path = Rails.root.join('public', 'data', 'ART.json')
    # class_schedules = JSON.parse(File.read(file_path))
    class_schedules=read_all_json_from_directory(Rails.root.join('public', 'data'))
    @days=["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    day_map = {"Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5}
    @periods=[1,2,3,4,5,6,7]
    @taken_timeslots = process_schedules_for_availability(class_schedules)
    @available_rooms=[]
    if not params.empty?
      @available_rooms=@taken_timeslots[day_map[params[:date]]][params[:period].to_i]
    end
    # debugger
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
        if s["i"][0]&.dig("p") > 8
          tens=s["i"][0]&.dig("p")/10
          ones=s["i"][0]&.dig("p")%10
          (tens..ones).each do |period|
            data[s["i"][0]&.dig("d")][period][s["i"][0]&.dig("l")] =s["b"]
          end
          # debugger
        else
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")][s["i"][0]&.dig("l")] =s["b"]
        end
      rescue
        begin
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")]={}
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")][s["i"][0]&.dig("l")] =s["b"]
        rescue
          dropped+=1
          # p s
        end
      end
    end
    return data
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
