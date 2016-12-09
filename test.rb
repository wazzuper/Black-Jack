require_relative 'gambler'
require_relative 'player'
require_relative 'dealer'
require_relative 'cards'
require_relative 'black_jack'

player = Player.new
dealer = Dealer.new
cards = Cards.create_deck
game = BlackJack.new(player, dealer, cards)

game.game_begin