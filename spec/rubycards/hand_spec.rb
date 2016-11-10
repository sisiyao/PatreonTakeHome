require 'spec_helper'

include RubyCards

shared_examples "RubyCards::Hand" do
  let (:deck) { Deck.new }
  let (:hand) { Hand.new }
  let (:queen_c) { Card.new('Queen', 'Clubs') }
  let (:three_s) { Card.new(3, 'Spades') }
  let (:jack_d) { Card.new('Jack', 'Diamonds') }
  let (:seven_h) { Card.new(7, 'Hearts') }

  describe '#initialize' do
    context 'no params' do
      it 'should be empty' do
        expect(hand.cards).to eq []
      end
    end

    context 'params' do
      it 'should return a hand full of the passed-in cards' do
        two_card_hand = Hand.new [queen_c, three_s]
        expect(two_card_hand.cards.size).to eq 2
        [queen_c, three_s].each do |card|
          expect(two_card_hand.cards).to include card
        end

        four_card_hand = Hand.new [queen_c, jack_d, seven_h, three_s]
        expect(four_card_hand.cards.size).to eq 4
        [queen_c, jack_d, seven_h, three_s].each do |card|
          expect(four_card_hand.cards).to include card
        end
      end
    end
  end

  describe '#sort!' do
    it 'should put the cards in comparator order' do
      two_card_hand = Hand.new [queen_c, three_s]
      two_card_hand.sort!
      expect(two_card_hand.cards).to eq [three_s, queen_c]

      four_card_hand = Hand.new [queen_c, seven_h, three_s, jack_d]
      four_card_hand.sort!
      expect(four_card_hand.cards).to eq [three_s, seven_h, jack_d, queen_c]
    end
  end

  describe '#draw' do
    context 'full deck with draw count' do
      it "should draw the specified number of cards" do
        hand.draw(deck, 2)
        expect(hand.cards.size).to eq 2
        # first two cards in a new, un-shuffled deck are the two of clubs and two of diamonds
        two_c = Card.new(2, 'Clubs')
        two_d = Card.new(2, 'Diamonds')
        [two_c, two_d].each do |card|
          expect(hand.cards).to include card
        end

        hand.draw(deck, 2)
        expect(hand.cards.size).to eq 4
        # next two cards are the other two twos
        [two_c, two_d, Card.new(2, 'Spades'), Card.new(2, 'Hearts')].each do |card|
          expect(hand.cards).to include card
        end
      end
    end

    context 'deck is low on cards' do
      it "should draw the the deck down to empty" do
        bunk_hand = Hand.new
        bunk_hand.draw(deck, 50)

        # only 52 cards in a deck, so we only draw twice
        hand.draw(deck, 4)
        expect(hand.cards.size).to eq 2
        expect(deck.cards.size).to eq 0

        hand.draw(deck, 4)
        expect(hand.cards.size).to eq 2
        expect(deck.cards.size).to eq 0
      end
    end

    context 'no draw count' do
      it "should default to drawing one card" do
        hand.draw(deck)
        expect(hand.cards.size).to eq 1
        hand.draw(deck)
        expect(hand.cards.size).to eq 2
      end
    end
  end
end

describe Hand do
  it_behaves_like "RubyCards::Hand"
end
