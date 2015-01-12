class Cell
  attr_reader :coordinates, :value

  def initialize(coordinates, value)
    @coordinates = coordinates
    @value = value
  end
end
