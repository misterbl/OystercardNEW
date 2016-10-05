require_relative 'oystercard'


class Journey

attr_reader :in_journey, :current_journey
attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 6
  FARE = 1

  def initialize
    @current_journey = {}
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(station)
    if @in_journey == true
      create_journey
    else
      @in_journey = true
      @entry_station = station
    end
  end

  def finish_journey(station)
    @exit_station = station
    create_journey
    @in_journey = false
  end

  def create_journey
    if @entry_station == nil
      @entry_station = :Incomplete_journey
    elsif @exit_station == nil
      @exit_station = :Incomplete_journey
    end
    @current_journey = { entry_station: @entry_station, exit_station: @exit_station }
  end

  def clear_current_journey
    @entry_station = nil
    @exit_station = nil
  end

  def incomplete_journey
    @in_journey
  end

  def fare
    if @entry_station == nil
      PENALTY_FARE
    elsif @exit_station == nil
      PENALTY_FARE
    else
      FARE
    end
  end

end
