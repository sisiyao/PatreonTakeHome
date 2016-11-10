require_relative 'lib/rubycards'
include RubyCards

dealer = Poker::TexasHoldemDealer.new
p1 = Poker::TexasHoldemPlayer.new("P1")
p2 = Poker::TexasHoldemPlayer.new("P2")

dealer.deal([p1.hand, p2.hand])

dealer.flop
dealer.turn
dealer.river

puts "board:\n#{dealer.board}"
puts p1
puts p2

p1_best_hand = p1.best_hand(dealer.board).sort!
p2_best_hand = p2.best_hand(dealer.board).sort!

if p1_best_hand > p2_best_hand
  puts "P1 wins! with a\n#{p1_best_hand}\nto p2's\n#{p2_best_hand}"
elsif p2_best_hand > p1_best_hand
  puts "P2 wins! with a\n#{p2_best_hand}\nto p1's\n#{p1_best_hand}"
else
  puts "TIE GAME!\n#{p1_best_hand}\nand\n#{p2_best_hand}\nare dead equal!"
end