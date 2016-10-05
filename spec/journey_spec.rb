require 'journey'

describe Journey do

  let(:card) {double :oystercard}
  let(:mudchute) {double :station}
  let(:bank) {double :station}

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

end
