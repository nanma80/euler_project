class Hand
  attr_reader :cards

  def initialize(input_string)
    @cards = []
    input_string.split(' ').each do |card_string|
      @cards << Card.new(card_string)
    end
  end
end