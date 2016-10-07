require 'journey_log'

describe JourneyLog do
  subject(:journeylog) {described_class.new}
  let(:journey) {double :journey  }
  describe "#initialize" do
    it "initialize with a journey history" do
      expect(journeylog.journey_history).to be_an Array
    end
  end

  describe "#log" do
    it "log a journey into the history", focus: true do
        journeylog.log(journey)
        expect(journeylog.journey_history).to include journey
    end
  end
end
