class Card
  attr_reader :value, :suit, :input_string

  def initialize(input)
    raise "Incorrect input length #{input}" if input.length != 2
    @value = input[0].to_sym
    @suit = input[1].to_sym
    unless self.class.values.include?(value) && self.class.suits.include?(suit)
      raise "Input not recognized #{input}" 
    end
    @input_string = input
  end

  def numeric
    self.class.values.index(@value) + 2
  end

  def to_s
    @input_string
  end

  class << self
    def suits
      [:H, :C, :D, :S]
    end

    def values
      [*(2..9).map {|n| n.to_s.to_sym}, :T, :J, :Q, :K, :A]
    end
  end
end
