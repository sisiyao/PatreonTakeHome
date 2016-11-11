require_relative '../../deck'
require_relative '../../hand'

module RubyCards
  module Poker
    class TexasHoldemDealer
      attr_reader :board

      def initialize
        @deck = Deck.new
        @board = Hand.new
      end

      def deal(hands)
        hands.each do |hand|
          2.times { |i| hand << @deck.draw }
        end
      end

      def flop
        @deck.draw
        3.times { |i| @board << @deck.draw }
      end

      def turn
        @deck.draw
        @board << @deck.draw
      end

      alias :river :turn
    end
  end
end
