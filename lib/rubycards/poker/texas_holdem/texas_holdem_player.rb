require_relative '../../deck'
require_relative '../../hand'

module RubyCards
  module Poker
    class TexasHoldemPlayer
      attr_accessor :hand

      def initialize(name="Player")
        @name = name
        @hand = Hand.new
      end

      def to_s
        "#{@name}: #{@hand}"
      end

      def best_hand(board)
        best = PokerHand.new(board.cards)
        all_cards = @hand.cards + board.cards
        combinations = all_cards.combination(5).to_a
        combinations.each do |cards|
          new_hand = PokerHand.new(cards)
          best = new_hand if new_hand > best
        end
        best
      end
    end
  end
end
