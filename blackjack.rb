require "pry"

class Deck
  def initialize
    value = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suit = ["Spare", "Diamond", "Heart", "Club"]
    @deck = value.product(suit)
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
  
end

class Human < Player
end 

class Dealer < Player
end

class Game

  def initialize
    @deck = Deck.new
    @player = Player.new("Roy")
    @dealer = Dealer.new("Dealer")
    @current_caller = @player
  end

  def deal_a_card
    if @current_caller == @player
      @player.hand << @deck.deal
    else 
      @dealer.hand << @deck.deal
    end
  end

  def change_caller
    if @current_caller == @player
      @current_caller = @dealer
    else 
      @current_caller = @player
    end
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

end

binding.pry