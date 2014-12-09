class BufferString
  attr_reader :length

  def initialize
    @string = ''
    @length = 0
  end

  def << (suffix)
    @string << suffix
    @length += suffix.length
  end

  def to_s
    @string
  end

  def [](index)
    @string[index]
  end
end

class ChampernownesConstant
  def initialize(length)
    @string = BufferString.new
    current_number = 1
    while @string.length < length
      @string << current_number.to_s(10)
      current_number += 1
    end
  end

  def get_digit(position)
    @string[position - 1].to_i
  end
end

c = ChampernownesConstant.new(10 ** 6)
product = 1
(0..6).each do |exponent|
  position = 10 ** exponent
  product *= c.get_digit(position)
end
puts product

