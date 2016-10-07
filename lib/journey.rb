require_relative 'oystercard'
require_relative 'station'


class Journey

attr_reader :in_journey, :current_journey, :entry_zone, :exit_zone, :entry_station_name, :exit_station_name
attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station_name, entry_zone)
    @entry_station_name = entry_station_name; @entry_zone = entry_zone
    @entry_station = Station.new(@entry_station_name, @entry_zone)
    @exit_station = nil
  end

  def finish_journey(exit_station_name, exit_zone)
    @exit_station_name = exit_station_name; @exit_zone = exit_zone
    @exit_station = Station.new(@exit_station_name, @exit_zone)
  end

  def unknown_station
    Station.new("Unknown Station", "Unknown Zone")
  end

  def fare_calc
    1 + (@entry_zone - @exit_zone).abs
  end

end
