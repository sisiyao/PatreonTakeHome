require 'spec_helper'
require_relative '../hand_spec'

include RubyCards::Poker

describe PokerHand do
  it_behaves_like "RubyCards::Hand"

  let (:queen_high_straight_flush) { PokerHand.new [
    Card.new(8, 'Clubs'),
    Card.new(9, 'Clubs'),
    Card.new(10, 'Clubs'),
    Card.new('Jack', 'Clubs'),
    Card.new('Queen', 'Clubs')
  ]}
  let (:four_jacks_queen_kicker) { PokerHand.new [
    Card.new('Jack', 'Clubs'),
    Card.new('Jack', 'Diamonds'),
    Card.new('Jack', 'Hearts'),
    Card.new('Jack', 'Spades'),
    Card.new('Queen', 'Clubs')
  ]}
  let (:kings_full_of_sixes) { PokerHand.new [
    Card.new('King', 'Hearts'),
    Card.new(6, 'Clubs'),
    Card.new('King', 'Spades'),
    Card.new(6, 'Diamonds'),
    Card.new('King', 'Clubs')
  ]}
  let (:king_high_flush) { PokerHand.new [
    Card.new(8, 'Clubs'),
    Card.new(9, 'Clubs'),
    Card.new('Jack', 'Clubs'),
    Card.new('Queen', 'Clubs'),
    Card.new('King', 'Clubs')
  ]}
  let (:queen_high_straight) { PokerHand.new [
    Card.new(8, 'Diamonds'),
    Card.new(9, 'Clubs'),
    Card.new(10, 'Clubs'),
    Card.new('Jack', 'Clubs'),
    Card.new('Queen', 'Clubs')
  ]}
  let (:three_threes) { PokerHand.new [
    Card.new('Jack', 'Clubs'),
    Card.new(3, 'Diamonds'),
    Card.new(3, 'Hearts'),
    Card.new(3, 'Spades'),
    Card.new('Queen', 'Clubs')
  ]}
  let (:two_fours_two_jacks) { PokerHand.new [
    Card.new('Jack', 'Clubs'),
    Card.new('Jack', 'Diamonds'),
    Card.new(4, 'Hearts'),
    Card.new(4, 'Spades'),
    Card.new('Queen', 'Clubs')
  ]}
  let (:pair_of_kings) { PokerHand.new [
    Card.new('King', 'Clubs'),
    Card.new('King', 'Diamonds'),
    Card.new(4, 'Hearts'),
    Card.new(7, 'Spades'),
    Card.new('Queen', 'Clubs')
  ]}
  let (:jack_high) { PokerHand.new [
    Card.new(6, 'Clubs'),
    Card.new(9, 'Diamonds'),
    Card.new(4, 'Hearts'),
    Card.new('Jack', 'Clubs'),
    Card.new(7, 'Spades'),
  ]}
  let (:seven_high) { PokerHand.new [
    Card.new(2, 'Clubs'),
    Card.new(3, 'Diamonds'),
    Card.new(4, 'Hearts'),
    Card.new(5, 'Clubs'),
    Card.new(7, 'Spades'),
  ]}

  describe "#hand_type" do
    it "should be a :straight_flush when it's a straight flush" do
      expect(queen_high_straight_flush.hand_type).to eq :straight_flush
    end

    it "should be a :four_of_a_kind when it's a four-of-a-kind" do
      expect(four_jacks_queen_kicker.hand_type).to eq :four_of_a_kind
    end

    it "should be a :full_house when it's a full house" do
      expect(kings_full_of_sixes.hand_type).to eq :full_house
    end

    it "should be a :flush when it's a flush" do
      expect(king_high_flush.hand_type).to eq :flush
    end

    it "should be a :straight when it's a straight" do
      expect(queen_high_straight.hand_type).to eq :straight
    end

    it "should be a :three_of_a_kind when it's a three-of-a-kind" do
      expect(three_threes.hand_type).to eq :three_of_a_kind
    end

    it "should be a :two_pair when it's two pair" do
      expect(two_fours_two_jacks.hand_type).to eq :two_pair
    end

    it "should be a :one_pair when it's one pair" do
      expect(pair_of_kings.hand_type).to eq :one_pair
    end

    it "should be a :high_card when it's nothing else" do
      expect(jack_high.hand_type).to eq :high_card
    end
  end

  describe "#<=>" do
    it "should be compare in poker order" do
      expect(queen_high_straight_flush).to be > four_jacks_queen_kicker
      expect(four_jacks_queen_kicker).to be > kings_full_of_sixes
      expect(kings_full_of_sixes).to be > king_high_flush
      expect(king_high_flush).to be > queen_high_straight
      expect(queen_high_straight).to be > three_threes
      expect(three_threes).to be > two_fours_two_jacks
      expect(two_fours_two_jacks).to be > pair_of_kings
      expect(pair_of_kings).to be > jack_high
      expect(jack_high).to be > seven_high
    end

    context "when hands have the same hand_type" do
      context "when they are straights" do
        let (:king_high_straight) { PokerHand.new [
          Card.new(9, 'Diamonds'),
          Card.new(10, 'Diamonds'),
          Card.new('Jack', 'Diamonds'),
          Card.new('Queen', 'Diamonds'),
          Card.new('King', 'Clubs')
        ]}
        let (:king_high_straight_flush) { PokerHand.new [
          Card.new(9, 'Clubs'),
          Card.new(10, 'Clubs'),
          Card.new('Jack', 'Clubs'),
          Card.new('Queen', 'Clubs'),
          Card.new('King', 'Clubs')
        ]}

        it "should compare by the rank of the highest card" do
          expect(king_high_straight_flush).to be > queen_high_straight_flush
          expect(king_high_straight).to be > queen_high_straight
        end
      end

      context "when they are flushes" do
        let (:queen_high_flush) { PokerHand.new [
          Card.new(7, 'Clubs'),
          Card.new(8, 'Clubs'),
          Card.new(9, 'Clubs'),
          Card.new('Jack', 'Clubs'),
          Card.new('Queen', 'Clubs')
        ]}

        it "should compare by the rank of the highest card" do
          expect(king_high_flush).to be > queen_high_flush
        end
      end

      context "when they are X-of-a-kind" do
        let (:three_sevens) { PokerHand.new [
          Card.new('Jack', 'Clubs'),
          Card.new(7, 'Diamonds'),
          Card.new(7, 'Hearts'),
          Card.new(7, 'Spades'),
          Card.new(10, 'Clubs')
        ]}
        let (:jacks_full_of_aces) { PokerHand.new [
          Card.new('Jack', 'Hearts'),
          Card.new('Ace', 'Clubs'),
          Card.new('Jack', 'Spades'),
          Card.new('Ace', 'Diamonds'),
          Card.new('Jack', 'Clubs')
        ]}
        let (:kings_full_of_nines) { PokerHand.new [
          Card.new('King', 'Hearts'),
          Card.new(9, 'Clubs'),
          Card.new('King', 'Spades'),
          Card.new(9, 'Diamonds'),
          Card.new('King', 'Clubs')
        ]}

        it "should compare by the rank of the largest X-of-a-kind group" do
          expect(three_sevens).to be > three_threes

          expect(kings_full_of_nines).to be > kings_full_of_sixes
          expect(kings_full_of_sixes).to be > jacks_full_of_aces
        end
      end

      context "when they are differentiated by the kicker" do
        let (:three_threes_king_kicker) { PokerHand.new [
          Card.new(10, 'Clubs'),
          Card.new(3, 'Diamonds'),
          Card.new(3, 'Hearts'),
          Card.new(3, 'Spades'),
          Card.new('King', 'Clubs')
        ]}

        it "should compare by the rank of the highest kicker" do
          expect(three_threes_king_kicker).to be > three_threes#_queen_kicker
        end
      end

      context "when they are the same hand exactly" do
        let (:two_fours_two_jacks_2) { PokerHand.new [
          Card.new('Jack', 'Hearts'),
          Card.new('Jack', 'Spades'),
          Card.new(4, 'Clubs'),
          Card.new(4, 'Diamonds'),
          Card.new('Queen', 'Spades')
        ]}

        it "should say they're equal" do
          expect(two_fours_two_jacks).to eq two_fours_two_jacks_2
        end
      end
    end
  end
end
