require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance, :current_journey,:entry_station, :exit_station, :entry_zone,
              :exit_zone, :entry_station_name, :exit_station_name
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
    @entry_station_name = entry_station_name; @entry_zone = entry_zone
    double_entry if @current_journey != nil
    start_journey(@entry_station_name, @entry_zone)
  end

  def start_journey(entry_station_name, entry_zone)
    @current_journey = Journey.new(@entry_station_name, @entry_zone)
  end

  def touch_out(exit_station_name, exit_zone)
    set_exit_parameters(exit_station_name, exit_zone)
    if @current_journey == nil
    double_exit(@exit_station_name, @exit_zone)
    else
    @current_journey.finish_journey(@exit_station_name, @exit_zone)
    deduct(@current_journey.fare_calc)
    log_journey(@current_journey)
    end
  end

  def double_entry
    deduct(Journey::PENALTY_FARE)
    @current_journey.exit_station = @current_journey.unknown_station
    log_journey(@current_journey)
  end

  def double_exit(exit_station_name, exit_zone)
    set_exit_parameters(exit_station_name, exit_zone)
    double_exit_journey = Journey.new("Unknown Station", "Unknown Zone")
    double_exit_journey.exit_station = double_exit_journey.finish_journey(@exit_station_name, @exit_zone)
    deduct(Journey::PENALTY_FARE); log_journey(double_exit_journey)
  end

  def unknown_station
    Station.new("Unknown Station", "Unknown Zone")
  end

#private
  def log_journey(journey)
    @journey_log.log(journey)
    @current_journey = nil
  end

  def deduct(fare)
    @balance -= fare
  end

  def set_exit_parameters(exit_station_name, exit_zone)
    @exit_station_name = exit_station_name; @exit_zone = exit_zone
  end

end
