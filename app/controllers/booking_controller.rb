class BookingController < ApplicationController
  
  
  def index
    # file_path = Rails.root.join('public', 'data', 'ART.json')
    # class_schedules = JSON.parse(File.read(file_path))
    class_schedules=read_all_json_from_directory(Rails.root.join('public', 'data'))
    day_map = {"Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5}
    @taken_timeslots = process_schedules_for_availability(class_schedules)
    @available_rooms=[]
    # debugger
    if search_params?
      # @available_rooms=@all_rooms.difference(@taken_timeslots[day_map[params[:date]]][params[:period].to_i].select { |key, value| value.is_a?(String) }.keys).to_a
      # @taken_by_other_users = @all_rooms.difference(@taken_timeslots[day_map[params[:date]]][params[:period].to_i].select { |key, value| value.is_a?(Array) }.keys).to_a
      @available_rooms = @all_rooms.each_with_object({}) do |room, available_rooms|
        timeslot = @taken_timeslots[day_map[params[:date]]][params[:period].to_i]
        if timeslot && timeslot.has_key?(room) && timeslot[room].is_a?(Array)
          if !timeslot[room].include?(session[:user_id])
            available_rooms[room] = timeslot[room]
          end
        elsif timeslot && !timeslot.has_key?(room)
          available_rooms[room] = nil
        end
      end
      # debugger
      @selected={date: params[:date], period: params[:period]}
    end
  end

  def create
    if session[:user_id].nil?
      flash[:alert] = "You need to log in to book"
    else
      @user=User.find(session[:user_id])
      booking=Booking.create(user_id: session[:user_id], date: next_weekday(params[:date]), period: params[:period], room_number: params[:room])
      # debugger
      if booking.valid?
        flash[:notice] = "Booking created successfully!"
      else
        flash[:alert] = "Error making this booking"
      end
    end
    redirect_to booking_index_path
  end

private

  def next_weekday(start_day)
    weekdays = { "Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5 }
    start_day_int = weekdays[start_day]
    today = Date.today
    diff = start_day_int - today.wday
    diff += 7 if diff < 0
    today + diff
  end
  
  # def day_of_week(date)
  #   day_index = date.wday
  #   day_names = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
  #   day_names[day_index]
  # end
  
  def search_params?
    params.key?(:date) and params.key?(:period)
  end

  def booking_params
    params.require(:booking).permit(:date, :period, :room_number)  # Replace with allowed booking attributes
  end

  def process_schedules_for_availability(schedules)
    data = ([-1] + (1..6).to_a).each_with_object({}) do |day, hash|
      hash[day] = (1..7).each_with_object({}) do |location, inner_hash|
        inner_hash[location] ={} 
      end
    end

    dropped=0

    @all_rooms=Set.new
    
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
          @all_rooms.add(s["i"][0]&.dig("l"))
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")][s["i"][0]&.dig("l")] =s["b"]
        end
      rescue
        begin
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")]={}
          
          @all_rooms.add(s["i"][0]&.dig("l"))
          data[s["i"][0]&.dig("d")][s["i"][0]&.dig("p")][s["i"][0]&.dig("l")] =s["b"]
        rescue
          dropped+=1
          # p s
        end
      end
    end
    
    today = Date.today
    today_wday = today.wday
    days_to_subtract = today_wday == 0 ? 6 : today_wday - 1
    week_start = today - days_to_subtract
    week_end = week_start + 6

    Booking.all().each do |booking|
      if booking.date >= week_start and booking.date < week_end
        data[booking.date.wday][booking.period][booking.room_number] ||= []
        data[booking.date.wday][booking.period][booking.room_number] << booking.user.id
      end
    end
    # debugger
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
