class Cell
  attr_reader :x, :y, :value

  def initialize(x, y, value)
    @x = x
    @y = y
    @value = value
  end

  def block_id
    [ x/3, y/3 ].to_s
  end

  def to_s
    value.to_s
  end
end