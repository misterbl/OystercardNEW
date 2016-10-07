require_relative 'oystercard'
require_relative 'station'


class Journey

attr_reader :in_journey, :current_journey, :entry_zone, :exit_zone, :entry_station_name, :exit_station_name
attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station_name, entry_zone)
    @entry_station_name = entry_station_name
    @entry_zone = entry_zone
    @entry_station = Station.new(@entry_station_name, @entry_zone)
    @exit_station = nil
    # in_journey?
  end

  # def start_journey(station)
  #   if
  #     create_journey
  #   else
  #     @in_journey = true
  #     @entry_station = station
  #   end
  # end

  def finish_journey(exit_station_name, exit_zone)
    @exit_station_name = exit_station_name
    @exit_zone = exit_zone
    @exit_station = Station.new(@exit_station_name, @exit_zone)
    # create_journey
  end


  def fare_calc
    1 + (@entry_zone - @exit_zone).abs
  end
  # def create_journey
  #   if @entry_station == nil
  #     @entry_station = :Incomplete_journey
  #   elsif @exit_station == nil
  #     @exit_station = :Incomplete_journey
  #   end
  #   @current_journey = { entry_station: @entry_station, exit_station: @exit_station }
  # end


  # def in_journey?
  #   true
  # end


  # def fare
  #   if (@exit_station && @entry_station) != nil
  #     PENALTY_FARE
  #   elsif @exit_station == nil
  #     PENALTY_FARE
  #   else
  #     FARE
  #   end
  # end

end
