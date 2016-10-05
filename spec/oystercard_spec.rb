require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

    before do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
    end

  #, balance => Oystercard::MINIMUM_BALANCE
  let(:mudchute) {double :station}
  let(:bank)     {double :station}

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
      expect(card.balance).to eq Oystercard::MINIMUM_BALANCE - Oystercard::FARE
    end

  end

  context 'touching in and out - ' do




    it 'raises error if card below minimum balance when touching in' do
      card.top_up(-1)
      expect{card.touch_in(mudchute)}.to raise_error "Insufficient funds for journey"
    end


    it 'charges the card on touch out' do
      card.touch_in(mudchute)
      expect{card.touch_out(bank)}.to change{card.balance}.by(-Oystercard::FARE)
    end
  end

  context 'journey status and history' do


    it 'expects station to be nil after touch out' do
      card.touch_in(mudchute)
      card.touch_out(bank)
      expect(card.entry_station).to eq nil
    end


  end

  context 'Journey history' do

    it 'has an empty journey history by default' do
      expect(card.card_history).to eq []
    end


  end


end
