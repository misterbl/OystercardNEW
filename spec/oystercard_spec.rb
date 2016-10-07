require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

    before do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
    end

  #, balance => Oystercard::MINIMUM_BALANCE
  let(:mudchute) {double :entry_station_name}
  let(:bank)     {double :exit_station_name}
  let(:current_journey) {double :current_journey}

  before :each do
    allow(current_journey).to receive(:zone).and_return(2)
    allow(current_journey).to receive(:name).and_return('mudchute')
  end

  context 'balance' do
    it 'have balance' do
      expect(card).to respond_to :balance
    end
  end

  context '#top up' do

    it 'limits top up value MONEY_LIMIT' do
      card.top_up(Oystercard::MONEY_LIMIT - 1)
      expect{card.top_up(1)}.to raise_error "Card limit is #{Oystercard::MONEY_LIMIT}."
    end

  end

  context '#money coming off card' do

    it 'deducts fare per journey' do
      card.touch_in(mudchute)
      card.touch_out(bank)
      expect(card.balance).to eq Oystercard::MINIMUM_BALANCE - Journey::FARE
    end

  end

  context 'touching in and out - ' do

    it 'raises error if card below minimum balance when touching in', focus: true do
      card.top_up(-1)
      expect{card.touch_in('mudchute',2)}.to raise_error "Insufficient funds for journey"
    end

    it 'creates a new journey on touch_in', focus: true do
      card.touch_in('mudchute', 2)
      expect(card.current_journey).to be_a_kind_of Journey
    end

    it 'charges the card on touch out' do
      card.touch_in(mudchute)
      expect{card.touch_out(bank)}.to change{card.balance}.by(-Journey::FARE)
    end

  end


  context 'Journey history' do

    it 'has an empty journey history by default' do
      expect(card.card_history).to eq []
    end

  end
  #
  # it 'charges a penalty fare for incomplete entry stations' do
  #
  # end
  #
  # it 'charges a penalty fare for incomplete exit stations' do
  #
  # end
  #
  # it 'charges a correct fare when both stations registered' do
  #
  # end



end
