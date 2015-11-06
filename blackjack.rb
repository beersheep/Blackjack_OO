require "pry"

class Deck
  def initialize
    value = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suit = ["Spare", "Diamond", "Heart", "Club"]
    @deck = (value.product(suit))
  end
end

binding.pry

