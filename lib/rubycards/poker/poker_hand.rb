require_relative '../hand'
require_relative 'tie_break'

module RubyCards
  module Poker
    class PokerHand < Hand
      include Comparable
      include TieBreak

      HAND_TYPES = [
        :royal_flush,
        :straight_flush,
        :four_of_a_kind,
        :full_house,
        :flush,
        :straight,
        :three_of_a_kind,
        :two_pair,
        :one_pair,
        :high_card
      ]

      def hand_type
        HAND_TYPES.each do |type|
          return type if self.send("#{type}?")
        end
      end

      def <=>(other_hand)
        if hand_type != other_hand.hand_type
          HAND_TYPES.reverse.index(hand_type) <=> HAND_TYPES.reverse.index(other_hand.hand_type)
        else
          tie_breaker(other_hand)
        end
      end

      def card_rank_count(rank)
        @cards.map(&:rank).count(rank)
      end

      def has_a?(rank_or_suit)
        @cards.any? do |card|
          card.rank == rank_or_suit || card.suit == rank_or_suit
        end
      end

      def pairs
        pairs = []
        @cards.sort.map(&:rank).uniq.each do |rank|
          if card_rank_count(rank) == 2
            pairs << @cards.sort.select { |card| card.rank == rank }
          end
        end
        pairs
      end

      def royal?
        Deck.royal_ranks.map(&:to_s).all? do |rank|
          @cards.map(&:rank).include?(rank)
        end
      end

      def royal_flush?
        royal? && straight_flush?
      end

      def straight_flush?
        straight? && flush?
      end

      def four_of_a_kind?
        @cards.any? { |card| card_rank_count(card.rank) == 4 }
      end

      def full_house?
        three_of_a_kind? && one_pair?
      end

      def flush?
        @cards.map(&:suit).uniq.length == 1
      end

      def straight?
        if has_a?('Ace') && has_a?('2')
          straight = Deck.ranks[0..3] + ['Ace']
        else
          low_index = Deck.ranks.index(@cards.sort.first.rank)
          straight = Deck.ranks[low_index..(low_index + 4)]
        end
        @cards.sort.map(&:rank) == straight
      end

      def three_of_a_kind?
        @cards.any? { |card| card_rank_count(card.rank) == 3 }
      end

      def two_pair?
        pairs.count == 2
      end

      def one_pair?
        pairs.count == 1
      end

      def high_card?
        true
      end
    end
  end
end
