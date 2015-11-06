require "pry"

class Deck
  attr_accessor :deck
  def initialize
    value = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suit = ["Spare", "Diamond", "Heart", "Club"]
    @deck = (value.product(suit))
  end

  # def shuffle!
  #   @deck.shuffle!
  # end
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
  end

  def deal_a_card
    @player.hand << @deck.deal
  end

  def start_game
    4.times do 
      @deck.shuffle!
    end
    deal_a_card
    @dealer.hand << @deck.deal
    deal_a_card
    @dealer.hand << @deck.deal 
  end
end

binding.pry