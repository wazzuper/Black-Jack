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
      choice = gets.chomp.to_i
      case choice
      when 1
        if @money_dealer > 0 && @money_player > 0
          do_bet
          player_and_dealer_two_cards
          info
          selecting_actions_1
          case
          when @action == 1
            action_dealer
            selecting_actions_2
            case
            when @action == 1
              player_get_card
              end_game
            when @action == 2
              info
              end_game
            else
              puts 'Введите корректное число'
            end
          when @action == 2
            player_get_card
            info
            action_dealer
            end_game
          when @action == 3
            end_game
          else
            puts 'Введите корректное число'
          end
          info_bet
        else
          puts 'У вас кончились деньги!' if @money_player <= 0
          puts 'У дилера кончились деньги!' if @money_dealer <= 0
        end
      when 0
        break
      else
        puts 'Введите 1 или 0'
      end
    end
    goodbye
  end

  def enter_name
    @name ||= ''

    while @name == '' do
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

  def selecting_actions_1
    puts 'Что вы хотите сделать?'
    puts '1) Пропустить ход'
    puts '2) Взять карту'
    puts '3) Открыть карты'
    @action = gets.chomp.to_i
  end

  def selecting_actions_2
    puts 'Что вы хотите сделать?'
    puts '1) Добавить карту'
    puts '2) Открыть карты'
    @action = gets.chomp.to_i
   end

  def player_and_dealer_two_cards
    puts 'Дилер раздает карты...'
    2.times { @player.take_card(@cards) }
    2.times { @dealer.take_card(@cards) }
  end

  def action_dealer
    puts 'Ход дилера...'
    if @dealer.sum >= 18
      puts 'Дилер пропускает ход...'
    else
      @dealer.take_card(@cards)
      puts 'Дилер берет себе карту...'
    end
  end

  def player_get_card
    fail puts 'Колода пустая' if @cards.nil?
    @player.take_card(@cards)
    puts 'Дилер добавил вам карту...'
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

  def end_game
    puts 'Вы и дилер вскрываете карты...'
    puts "У вас #{@player.sum} очков"
    puts "У дилера #{@dealer.sum} очков"
    Gambler.winner(@player, @dealer)
    winner = Gambler.winner(@player, @dealer)
    if winner == @player
      puts 'Поздравляем, вы победили!'
      puts 'Дилер выплачивает ваш выигрыш'
      money_bank_win_player
    elsif winner == :no_one
      puts 'Никто не победил'
      puts 'Деньги остаются в банке'
    else
      puts 'Увы, вы проиграли'
      puts 'Дилер забирает деньги из банка себе'
      money_bank_win_dealer
    end
    @player.cards.clear && @dealer.cards.clear
  end

  def money_bank_win_player
    @money_player += @money_bank
    @money_bank = 0
  end

  def money_bank_win_dealer
    @money_dealer += @money_bank
    @money_bank = 0
  end

  def goodbye
    puts 'Удачи!'
  end
end