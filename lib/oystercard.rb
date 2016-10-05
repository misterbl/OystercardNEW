require_relative 'station'

class Oystercard

  attr_reader :balance, :entry_station,
              :exit_station, :current_journey,
              :card_history

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1


  def initialize
    @balance = 0
    @card_history = []
    @current_journey = {}

  end

  def top_up(money)
    fail "Card limit is #{MONEY_LIMIT}." if money + @balance > MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @journey.start_journey(station)
    @entry_station = station
  end

  def touch_out(station)
    deduct(FARE)
    @exit_station = station
    create_journey
  end

  def create_journey
    @current_journey = { entry_station: @entry_station, exit_station: @exit_station }
    @card_history << @current_journey
    clear_current_journey
  end

  def clear_current_journey
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    return false if @entry_station == nil
    true
  end


private

  def deduct(fare)
    @balance-= fare
  end


end
