require_relative 'gambler'
require_relative 'black_jack'

class Dealer < Gambler

  # Ход дилера
  def action_dealer
    puts 'Ход дилера...'
    if sum >= 18
      puts 'Дилер пропускает ход...'
    else
      take_card(@cards)
      puts 'Дилер берет себе карту...'
    end
  end
end