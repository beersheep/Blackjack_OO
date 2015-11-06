class Deck
  def initialize
    value = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suit = ["Spare", "Diamond", "Heart", "Club"]
    @deck = suit.product(value)
  end

  def shuffle!
    @deck.shuffle!
  end

  def deal
    @deck.pop
  end
end

class Player
  attr_accessor :hand
  def initialize(name)
    @name = name
    @hand = []
    
  end

  def total
    @total = 0 
    @hand.each do |card|
      if card[1] == "A"
        @total += 11
      elsif card[1].to_i == 0
        @total += 10
      else
        @total += card[1].to_i
      end  
    end
    if @total > Game::BLACKJACK
      @hand.select {|card| card[1] == "A"}.size.times do 
        @total -= 10
      end
    end
    @total
  end

  def blackjack?
    @total == Game::BLACKJACK ? true : false
  end

  def busted?
    @total > Game::BLACKJACK ? true :false
  end

end

class Game
  BLACKJACK = 21

  def initialize
    @deck = Deck.new
    @player = Player.new("Roy")
    @dealer = Player.new("Dealer")
    @current_caller = @player
  end

  def play
    setup_game
    display_table_info
    player_turn
    change_caller
    dealer_turn
    sleep 1.0
    show_hand
    check_winner
  end

  private

  def setup_game
    4.times do 
      @deck.shuffle!
    end
    loop do 
      deal_a_card
      change_caller
      break if @dealer.hand.size == 2
    end
  end

  def display_table_info
    puts "Dealer has a #{@dealer.hand[1]}"
    puts "================================"
    puts "You have #{@player.hand[0]} and #{@player.hand[1]}, total of #{@player.total}"
  end

  def player_turn
    loop do 
      if @player.blackjack?
        puts "Blackjack! You win!"
        play_again?
      end
      puts "Would you like to hit?(Y/N)"
      if gets.chomp.downcase == "y"
        deal_a_card
        puts "You get a #{@player.hand.last}, total of #{@player.total}"
        if @player.busted?
          puts "You are busted!"
          play_again?
        end
      else
        break
      end
    end
  end

  def change_caller
    if @current_caller == @player
      @current_caller = @dealer
    else 
      @current_caller = @player
    end
  end

  def dealer_turn
    system "clear"
    puts "Dealer have #{@dealer.hand[0]} and #{@dealer.hand[1]}, total of #{@dealer.total}"

    loop do 
      if @dealer.blackjack?
        puts "Dealer hits blackjack! You lose!"
        play_again? 
      end
      if @dealer.total < 17
        sleep 0.5
        puts "=> Dealer chooses to hit."
        deal_a_card
        puts "Dealer gets a #{@dealer.hand.last}, total of #{@dealer.total}"
        if @dealer.busted?
          puts "Dealer busted! You win!"
          play_again?
        end
      else 
        puts "=> Dealer chooses to stand."
        break
      end
    end
  end

  def show_hand
    system "clear"
    puts "Player's hand are"
    @player.hand.each {|card| puts "#{card}"}
    puts "the total of #{@player.total}"
    puts "=================================="
    puts "Dealer's hand are"
    @dealer.hand.each {|card| puts "#{card}"}
    puts "the total of #{@dealer.total}"
  end

  def check_winner
    if @player.total > @dealer.total
      puts "You win!"
    elsif @dealer.total > @player.total
      puts "Dealer wins!"
    else 
      puts "It's a push!"
    end
    play_again?
  end

  def deal_a_card
    if @current_caller == @player
      @player.hand << @deck.deal
    else 
      @dealer.hand << @deck.deal
    end
  end

  def play_again?
    loop do 
      puts "Would you like to play again?(Y/N)"
      if gets.chomp.downcase == "y"
        replay 
      else 
        puts "Thank you for playing!"
        exit
      end
    end
  end

  def replay 
    system "clear"
    @deck = Deck.new
    @player.hand.clear
    @dealer.hand.clear
    @current_caller = @player
    play
  end
  
end

Game.new.play