require "pry"

class Deck
  def initialize
    value = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suit = ["Spare", "Diamond", "Heart", "Club"]
    @deck = (value.product(suit))
  end
end

class Player
  def initialize(name)
    @name = name
    @hand = []
  end
end

class Dealer
  def initialize
    @name = "dealer"
    @hand = []
  end

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new("Roy")
    @dealer = Dealer.new 
  end

  def deal_a_card
    4.times do 
      @deck.shuffle!
    end

  end
  end

  def start_game
    4.times do 
      @deck.shuffle!
    end
    
  end
end