require_relative 'station'

class Oystercard

  attr_reader :balance, :current_journey,
              :card_history

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1



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
    if @journey.in_journey == true
      deduct(@journey.fare)
      @journey.start_journey(station)
    else
      @journey.start_journey(station)
    end
  end

  def touch_out(station)
    if @journey.in_journey == false
      deduct(@journey.fare)
      @journey.finish_journey(station)
    else
      @journey.finish_journey(station)
      deduct(@journey.fare)
      @card_history << @journey.current_journey
      @journey.clear_current_journey
    end
  end

private

  def deduct(fare)
    @balance -= fare
  end


end
