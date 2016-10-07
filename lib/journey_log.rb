require_relative 'oystercard'



class JourneyLog

attr_accessor :journey_history

  def initialize
    @journey_history = []
  end

  def log(journey)
    @journey_history << journey
  end

end
