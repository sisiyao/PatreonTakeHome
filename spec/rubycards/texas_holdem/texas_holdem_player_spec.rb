require 'spec_helper'

include RubyCards
include RubyCards::Poker

describe TexasHoldemPlayer do
  let (:player) { TexasHoldemPlayer.new }
  let (:queen_high_straight_flush) { PokerHand.new [
    Card.new(8, 'Clubs'),
    Card.new(9, 'Clubs'),
    Card.new(10, 'Clubs'),
    Card.new('Jack', 'Clubs'),
    Card.new('Queen', 'Clubs')
  ]}

  describe '#initialize' do
    it 'should start them with an empty hand' do
      expect(player.hand.cards.size).to eq 0
    end

    context 'with name' do
      it 'should print their name when printing their hand' do
        named_player = TexasHoldemPlayer.new('Jack')
        expect(named_player.to_s).to start_with ('Jack:')
      end
    end
  end

  describe '#best_hand' do
    context 'under normal circumstances' do
      it 'should combine its hand and the board for the best 5-card poker hand' do
        player.hand = Hand.new([Card.new('Jack', 'Clubs'), Card.new(8, 'Clubs')])
        board = Hand.new([
          Card.new(8, 'Diamonds'),
          Card.new(9, 'Clubs'),
          Card.new(10, 'Clubs'),
          Card.new('Jack', 'Diamonds'),
          Card.new('Queen', 'Clubs')
        ])

        best_hand = player.best_hand(board)
        expected_hand = queen_high_straight_flush
        expect(best_hand.cards.sort & expected_hand.cards.sort).to eq best_hand.cards.sort

        # the best hand doesn't always just have the highest cards
        player.hand = Hand.new([Card.new('Jack', 'Clubs'), Card.new(8, 'Clubs')])
        board = Hand.new([
          Card.new(8, 'Diamonds'),
          Card.new(8, 'Spades'),
          Card.new(10, 'Clubs'),
          Card.new('Jack', 'Diamonds'),
          Card.new('Queen', 'Clubs')
        ])

        best_hand = player.best_hand(board)
        expected_hand = eights_full_of_jacks
        expect(best_hand.cards.sort & expected_hand.cards.sort).to eq best_hand.cards.sort
      end
    end

    context "when the player's hand is unneeded to form the best hand" do
      it 'should just use the board cards' do
        player.hand = Hand.new([Card.new(2, 'Clubs'), Card.new(6, 'Diamonds')])
        board = queen_high_straight_flush

        best_hand = player.best_hand(board)
        expected_hand = queen_high_straight_flush
        expect(best_hand.cards.sort & expected_hand.cards.sort).to eq best_hand.cards.sort
      end
    end
  end
end
