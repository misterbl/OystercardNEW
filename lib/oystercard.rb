require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance, :current_journey,
              :entry_station, :exit_station, :entry_zone, :exit_zone,
              :entry_station_name, :exit_station_name
  attr_accessor :journey_log

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1



  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  def top_up(money)
    fail "Card limit is #{MONEY_LIMIT}." if money + @balance > MONEY_LIMIT
    @balance += money
  end

  def touch_in(entry_station_name, entry_zone)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    if @current_journey != nil
      double_entry
    end
    @entry_station_name = entry_station_name
    @entry_zone = entry_zone
    @current_journey = Journey.new(@entry_station_name, @entry_zone)
  end

  def touch_out(exit_station_name, exit_zone)
    @exit_station_name = exit_station_name
    @exit_zone = exit_zone
    if @current_journey == nil
      double_exit(@exit_station_name, @exit_zone)
    else
      @current_journey.finish_journey(@exit_station_name, @exit_zone)
      deduct(@current_journey.fare_calc)
      @journey_log.log(@current_journey)
      @current_journey = nil
    end
  end

  def double_entry
    deduct(Journey::PENALTY_FARE)
    @current_journey.exit_station = unknown_station
    @journey_log.log(@current_journey)
    @current_journey = nil
  end

  def double_exit(exit_station_name, exit_zone)
    @exit_station_name = exit_station_name
    @exit_zone = exit_zone
    double_exit_journey = Journey.new("Unknown Station", "Unknown Zone")
    double_exit_journey.exit_station = Station.new(@exit_station_name, @exit_zone)
    deduct(Journey::PENALTY_FARE)
    @journey_log.log(double_exit_journey)
    double_exit_journey = nil
    @current_journey = nil
  end

  def unknown_station
    Station.new("Unknown Station", "Unknown Zone")
  end


private

  def deduct(fare)
    @balance -= fare
  end


end
