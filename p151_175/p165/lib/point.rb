class Point
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates.map {|c| Rational(c)}
  end

  def x
    @coordinates[0]
  end

  def y
    @coordinates[1]
  end

end