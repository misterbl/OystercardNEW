require_relative 'oystercard'


class Journey

attr_reader :in_journey, :entry_station, :exit_station, :current_journey

  def initialize
    @current_journey = {}
  end

  def start_journey(station)
    @in_journey = true
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
    create_journey
    @in_journey = false
  end

  def create_journey
    @current_journey = { entry_station: @entry_station, exit_station: @exit_station }
    clear_current_journey
  end

  def clear_current_journey
    @entry_station = nil
    @exit_station = nil
  end


end
