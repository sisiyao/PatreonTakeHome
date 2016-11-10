# Texas Hold'em CLI -- An Interview Question by Patreon

## Prompt

You start with a library of `Card`s, `Deck`s, and `Hand`s, and RSpec tests covering those classes. Example usage you can find below.

Your goal is to extend this library with the classes it would need to run a basic command-line Texas Hold 'em game.
This game will be made of a `TexasHoldemDealer`, `TexasHoldemPlayer`s, and their `PokerHand`s.

You are given failing RSpec tests for each of these classes.
Run `rake spec` to run all tests, or e.g. `rspec spec/rubycards/texas_holdem/texas_holdem_dealer_spec.rb` to run just one test.

These tests should encode all the knowledge of Poker and Texas Hold'em you need for this problem,
so don't worry if you're not a poker expert.
If you would like more information to feel comfortable,
the sections "Poker Hand Rankings" and "The Play" at [this site](http://vegasclick.com/games/texasholdem.html)
(ignoring "1. Posting the Blinds" and all other such mentions of betting)
should be all you need to know.
Wikipedia, as always, is also a pretty good, if at times overly detailed, resource: [List of Poker Hands](https://en.wikipedia.org/wiki/List_of_poker_hands) and [Texas Hold'em : Play of the Hand](https://en.wikipedia.org/wiki/Texas_hold_%27em#Play_of_the_hand).

You are also given an example `example_game.rb` file which will play a quick 2-player Hold 'em game for you to watch.
Run with `ruby example_game.rb` (this will not work very well until you've written your code & tests pass!)

## Installation
```
cd #{the/unzipped/working/directory}
bundle install
```

To import the starting library into your current ruby runtime:
```
require_relative 'lib/rubycards'
include RubyCards
```
where `'lib/rubycards'` is appropriately relative to your current directory. Note: If you're on ruby 1.8 or lower, you'll have to replace `require_relative` with `require File.join(File.dirname(caller[0]), 'lib/rubycards')`. Or, you could just [update your ruby](http://rvm.io)


## Example usage of RubyCards library

Here's a trivial example of declaring a new deck, shuffling, and drawing 5 cards into a hand:

```ruby
require_relative 'lib/rubycards'
include RubyCards

hand = Hand.new
deck = Deck.new

deck.shuffle!

hand.draw(deck, 5)

puts hand
```

Here's a second example showing a deck made of 2 standard decks with the 2 and Jacks removed, shuffling, and drawing 10 cards into a hand:

```ruby
require_relative 'lib/rubycards'
include RubyCards

hand = Hand.new
deck = Deck.new(number_decks: 2, exclude_rank: [2, 'Jack'])

deck.shuffle!

hand.draw(deck, 10)

puts hand
```
