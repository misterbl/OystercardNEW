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
    @journey = Journey.new
  end

  def top_up(money)
    fail "Card limit is #{MONEY_LIMIT}." if money + @balance > MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    @journey.start_journey(station)
  end

  def touch_out(station)
    deduct(FARE)
    @journey.finish_journey(station)
    @card_history << @journey.current_journey
  end

private

  def deduct(fare)
    @balance-= fare
  end


end
