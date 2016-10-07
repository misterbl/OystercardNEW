require 'journey'

describe Journey do
  subject(:journey) {described_class.new(entry_station_name, entry_zone)}
  let(:journey) {double :journey}
  let(:entry_station) {double :entry_station}
  let(:entry_station_name) {double :entry_station_name}
  let(:entry_zone) {double :entry_zone}
  before do
  allow(journey).to receive(:entry_station_name).and_return('Waterloo')
  allow(journey).to receive(:entry_zone).and_return(1)
  allow(entry_station).to receive(:entry_station_name).and_return('Waterloo')
  allow(entry_station).to receive(:entry_zone).and_return(1)
  end

  describe "#initialize" do
    it "create a new station at initialize", focus: true do
    expect(entry_station).to be_a_kind_of Station
    end
  end
  it 'starting journey registers the card is in journey' do
    subject.start_journey(mudchute)
    expect(subject.in_journey).to eq true
  end

  it 'finishing journey registers that the card as no longer in journey' do
    subject.start_journey(mudchute)
    subject.finish_journey(bank)
    expect(subject.in_journey).to eq false
  end

  it 'stores a hash of entry and exit stations' do
    subject.start_journey(mudchute)
    subject.finish_journey(bank)
    expect(subject.current_journey).to include entry_station: mudchute, exit_station: bank
  end

  it 'begins with empty journey history by default' do
    expect(subject.current_journey).to be {}
  end

  it "calculates a penalty fare for no entry station" do
    subject.entry_station = nil
    subject.exit_station = :mudchute
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "calculates a penalty fare for no exit station" do
    subject.start_journey(mudchute)
    subject.exit_station = nil
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "calculate correct fare for full journey" do
    subject.start_journey(mudchute)
    subject.finish_journey(bank)
    expect(subject.fare).to eq Journey::FARE
  end

  it 'clears entry station on on completion of journey' do
    subject.start_journey(mudchute)
    subject.finish_journey(bank)
    subject.clear_current_journey
    expect(subject.entry_station).to eq nil
  end

  it 'clears entry station on on completion of journey' do
    subject.start_journey(mudchute)
    subject.finish_journey(bank)
    subject.clear_current_journey
    expect(subject.exit_station).to eq nil
  end

  it 'substitutes Incomplete journey for blank entry station' do
    subject.finish_journey(bank)
    expect(subject.create_journey).to include entry_station: :Incomplete_journey, exit_station: bank
  end

  it 'substitutes Incomplete journey for blank exit station' do
    subject.start_journey(mudchute)
    expect(subject.create_journey).to include entry_station: mudchute, exit_station: :Incomplete_journey
  end





end
