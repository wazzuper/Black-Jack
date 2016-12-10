require_relative 'gambler'
require_relative 'black_jack'

class Player < Gambler

  # Открываем карты игроку
  def card_face
    @card_face = []
    @cards.each { |t| @card_face << t.face }
    @card_face
  end

  # Игрок берет карту
  def player_get_card
    puts 'Колода пустая' if @cards.nil?
    take_card(@cards)
    puts 'Дилер добавил вам карту...'
  end
end