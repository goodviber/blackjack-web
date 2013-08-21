class Deck
  attr_accessor :cards

  def initialize
    suits = ['hearts', 'diamonds', 'spades', 'clubs']
    names_and_values = [['ace', 1], ['2', 2], ['3', 3], ['4', 4], ['5', 5],
      ['6', 6], ['7', 7], ['8', 8], ['9', 9], ['10', 10], ['jack', 10],
      ['queen', 10], ['king', 10]]
    @cards = []
    suits.product(names_and_values).each do |card_data|
      card_image = "#{card_data[0]}_#{card_data[1][0]}.jpg"
      card_value = card_data[1][1]
      card = Card.new(card_image, card_value)
      @cards.push(card)
    end
    shuffle
  end

  def shuffle
    self.cards.shuffle!
  end

  def deal
    self.cards.pop
  end
end

class Card
  attr_accessor :img, :value

  def initialize(img, value)
    @img = img
    @value = value
  end
end