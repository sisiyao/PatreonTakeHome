require 'spec_helper'

include RubyCards
include RubyCards::Poker


describe TexasHoldemDealer do
  let (:dealer) { TexasHoldemDealer.new }
  let (:player_1) { TexasHoldemPlayer.new }
  let (:player_2) { TexasHoldemPlayer.new }

  describe '#initialize' do
    it 'should start them with a normal deck and an empty board' do
      expect(dealer.board.cards.count).to eq 0
      expect(dealer.instance_variable_get(:@deck).cards.count).to eq 52
    end
  end

  describe '#deal' do
    it 'should deal two cards to each hand' do
      dealer.deal([player_1.hand, player_2.hand])
      expect(player_1.hand.cards.count).to eq 2
      expect(player_2.hand.cards.count).to eq 2
      expect(dealer.instance_variable_get(:@deck).cards.count).to eq 48
    end
  end

  describe '#flop' do
    it 'should burn a card then deal three cards to the board' do
      dealer.flop
      expect(dealer.board.cards.count).to eq 3
      expect(dealer.instance_variable_get(:@deck).cards.count).to eq 48
    end
  end

  describe '#turn' do
    it 'should burn a card then deal one cards to the board' do
      dealer.flop
      dealer.turn
      expect(dealer.board.cards.count).to eq 4
      expect(dealer.instance_variable_get(:@deck).cards.count).to eq 46
    end
  end

  describe '#river' do
    it 'should burn a card then deal one cards to the board' do
      dealer.flop
      dealer.turn
      dealer.river
      expect(dealer.board.cards.count).to eq 5
      expect(dealer.instance_variable_get(:@deck).cards.count).to eq 44
    end
  end
end
