class Cards
  attr_reader :value

  CARDS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITS = ['♥', '♦', '♣', '♠']
  VALUES = [[1, 11], [2], [3], [4], [5], [6], [7], [8], [9], [10], [10], [10], [10]]

  # Создаем колоду
  def self.create_deck
    deck = []

    SUITS.each do |suit|
      CARDS.each_with_index do |card, value|
        deck << Cards.new(card, suit, VALUES[value])
      end
    end

    deck.shuffle!
    deck
  end

  def initialize(card, suit, value)
    @card = card
    @suit = suit
    @value = value
  end

  # Видим карту и ее масть
  def face
    card + suit
  end

  private

  attr_reader :card, :suit
end