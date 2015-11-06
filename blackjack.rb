require "pry"

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

class Human < Player
end 

class Dealer < Player
end

class Game
  BLACKJACK = 21

  def initialize
    @deck = Deck.new
    @player = Player.new("Roy")
    @dealer = Dealer.new("Dealer")
    @current_caller = @player
  end

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

  def hit_or_stand
    puts "Would you like to hit?(Y/N)"
    loop do 
      if gets.chomp.downcase == "y"
        deal_a_card
        puts "You get a #{@player.hand.last}, total of #{@player.total}"
        break if game_over?
      else
        break
      end
    end

  end



  def play
    setup_game
    display_table_info
    hit_or_stand
  end


  private

  def change_caller
    if @current_caller == @player
      @current_caller = @dealer
    else 
      @current_caller = @player
    end
  end

  def deal_a_card
    if @current_caller == @player
      @player.hand << @deck.deal
    else 
      @dealer.hand << @deck.deal
    end
  end

  def display_table_info
    puts "Dealer has a #{@dealer.hand[1]}"
    puts "================================"
    puts "You have #{@player.hand[0]} and #{@player.hand[1]}, total of #{@player.total}"
  end

  def game_over?
    if @player.busted?
      puts "You are busted!"
      true
    elsif @player.blackjack?
      puts "Blackjack! You win!"
      true
    else
      false
    end
  end

end

Game.new.play

# binding.pry