def solutions(a, b, c)
  delta = b * b - 4.0 * a * c
  if delta < 0
    raise "#{delta}"
  end
  delta_sqrt = Math.sqrt(delta)
  [(-b + delta_sqrt)/2.0/a, (-b - delta_sqrt)/2.0/a]
end

class Direction
  attr_reader :to, :from

  def initialize(from, to)
    @from = from
    @to = to
  end

  def delta_x
    to[0] - from[0]
  end

  def delta_y
    to[1] - from[1]
  end

  def to_rad
    rad = Math.atan(delta_y / delta_x) + (delta_x > 0 ? 0.0 : Math::PI)
    rad % (2 * Math::PI)
  end

  def to_degree
    to_rad * 180 / Math::PI
  end
end

class Beam
  attr_reader :start_point, :direction

  def initialize(start_point, direction)
    @start_point = start_point
    @direction = direction
  end

  def hit
    return @hit unless @hit.nil?

    epsilon = 0.1 ** 10
    k = direction.delta_y/direction.delta_x
    d = start_point[1] - start_point[0] * k

    x_solutions = solutions(
      4.0 + k * k,
      2.0 * k * d,
      d * d - 100.0
      )

    hit_x = x_solutions.select do |x|
      (x - start_point[0]).abs > epsilon
    end.first


    hit_y = k * hit_x + d
    @hit = [hit_x, hit_y]
  end

  def reflect
    norm_rad = norm(hit).to_rad
    original_rad = direction.to_rad

    new_direction_rad = 2 * norm_rad - original_rad
    new_direction = Direction.new([0.0, 0.0], [Math.cos(new_direction_rad), Math.sin(new_direction_rad)])
    Beam.new(hit, new_direction)
  end

  def escape?
    hit[1] > 9.0 && hit[0] > -0.01 && hit[0] < 0.01
  end

  def norm(point)
    Direction.new([0.0, 0.0], [4.0 * point[0], point[1]])
  end
end

start_point = [0.0, 10.1]
first_hit = [1.4, -9.6]
first_direction = Direction.new(start_point, first_hit)

first_beam = Beam.new(start_point, first_direction)

beam = first_beam

count = 0
until beam.escape?
  beam = beam.reflect
  count += 1
end
p count

