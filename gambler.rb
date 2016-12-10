class Gambler
  attr_accessor :cards

  # Возвращаем результат сравнения сумм карт
  def self.winner(player, dealer)
    return :no_one if player.sum > 21 && dealer.sum > 21
    return :no_one if player.sum == dealer.sum
    return player if dealer.sum > 21
    return dealer if player.sum > 21
    player.sum > dealer.sum ? player : dealer
  end

  def initialize
    @money = 0
    @cards = []
  end

  # Берем карту
  def take_card(cards)
    cards.shuffle!
    @cards << cards[0]
  end

  # Сумма очков
  def sum
    @sum = 0
    @ace_count = ace_count
    @cards.each do |card|
      @sum += card.value.join.to_i if card.value.size == 1
    end
    ace_value!(@ace_count)
    @sum
  end

  private

  # 11 или 1 у туза
  def ace_value!(ace_count)
    ace_count.times do
      if @sum + 10 <= 21
        @sum += 11
      else
        @sum += 1
      end
    end
    @sum
  end

  # Считаем тузы в доступных картах
  def ace_count
    ace_count = 0
    @cards.each do |card|
      ace_count += 1 if card.value.size == 2
    end
    ace_count
  end
end