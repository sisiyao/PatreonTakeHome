$: << File.dirname(__FILE__)

require 'extensions/string'
require 'extensions/kernel' if RUBY_VERSION < "1.9"
require 'rubycards/card'
require 'rubycards/deck'
require 'rubycards/hand'
require 'rubycards/poker/poker_hand'
require 'rubycards/poker/texas_holdem/texas_holdem_dealer'
require 'rubycards/poker/texas_holdem/texas_holdem_player'
