require_relative 'dealer'
require_relative 'gambler'
require_relative 'player'

class BlackJack
  attr_accessor :play_game, :money_player, :money_dealer
  attr_accessor :money_bank, :money_bet, :player_sum, :dealer_sum

  def initialize(player, dealer, cards)
    @player = player
    @dealer  = dealer
    @cards = cards
    @money_player = 100
    @money_dealer = 100
    @money_bet = 10
  end

  def game_begin
    puts 'Добро пожаловать в игру Black Jack!'
    enter_name
    loop do
      puts 'Будем играть? 1 - да, 0 - нет'
      game_choice = gets.chomp.to_i
      case game_choice
      when 1
        break if enough_money? == false
        after_start
        menu
        case @menu_choice
        when 1
          player_skip_turn
        when 2
          player_choose_take_card
        when 3
          end_game
        end
      when 0
        break
      else
        puts 'Введите 1 или 0'
      end
      info_bet
    end
    goodbye
  end

  private

  def enter_name
    @name ||= ''

    while @name.empty?
      puts "Как вас зовут?"
      @name = gets.chomp.capitalize
      puts "Здравствуйте #{@name}!"
    end
  end

  def do_bet
    @money_bank = 0 if @money_bank.nil?
    @money_player -= @money_bet
    @money_dealer -= @money_bet
    @money_bank += @money_bet * 2
  end

  def after_start
    do_bet
    player_and_dealer_two_cards
    info
  end

  def player_choose_take_card
    @player.player_get_card
    info
    @dealer.action_dealer
    end_game
  end

  def player_skip_turn
    @dealer.action_dealer
    menu
    if @menu_choice == 2
      @player.player_get_card
      end_game
    elsif @menu_choice == 3
      end_game
    end 
  end

  def menu
    puts '1) Пропустить ход' if @menu_choice != 1
    puts '2) Взять карту' if @player.cards.size < 3
    puts '3) Открыть карты'
    @menu_choice = gets.chomp.to_i
  end

  def player_and_dealer_two_cards
    puts 'Дилер раздает карты...'
    2.times { @player.take_card(@cards) }
    2.times { @dealer.take_card(@cards) }
  end 

  def info
    puts "Ваши карты: #{@player.card_face}"
    puts "У вас: #{@player.sum} очков"
    puts "У Дилера #{@dealer.cards.size} карты"
  end

  def info_bet
    puts "В банке сейчас #{@money_bank} $"
    puts "У Дилера сейчас #{@money_dealer} $"
    puts "У Игрока сейчас #{@money_player} $"
  end

  def enough_money?
    if @money_dealer > 0 && @money_player > 0
      true
    else
      puts 'У вас кончились деньги!' if @money_player <= 0
      puts 'У дилера кончились деньги!' if @money_dealer <= 0
      false
    end
  end

  def end_game
    puts 'Вы и дилер вскрываете карты...'
    puts "У вас #{@player.sum} очков"
    puts "У дилера #{@dealer.sum} очков"
    @winner = Gambler.winner(@player, @dealer)
    if @winner == @player
      puts 'Поздравляем, вы победили!'
      puts 'Дилер выплачивает ваш выигрыш'
      money_bank_winner
    elsif @winner == :no_one
      puts 'Никто не победил'
      puts 'Деньги остаются в банке'
    else
      puts 'Увы, вы проиграли'
      puts 'Дилер забирает деньги из банка себе'
      money_bank_winner
    end
    @player.cards.clear && @dealer.cards.clear
  end

  def money_bank_winner
    @money_player += @money_bank if @winner == @player
    @money_dealer += @money_bank if @winner == @dealer
    @money_bank = 0
  end

  def goodbye
    puts 'Удачи!'
  end
end