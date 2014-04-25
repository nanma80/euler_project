class SpiralMatrix
  attr_reader :n, :value

  def initialize(n)
    @n = n
    @value = []
    n.times do
      @value << [0] * n
    end
    populate
  end

  def populate
    cur_value = 1
    coordinate = [(n - 1) / 2, (n - 1) / 2]
    direction = [-1, 0]
    while coordinate[0] >= 0 && coordinate[0] < n && coordinate[1] >= 0 && coordinate[1] < n
      @value[coordinate[0]][coordinate[1]] = cur_value
      cur_value += 1
      coordinate, direction = next_indices(coordinate, direction)
    end
  end

  def next_indices(coordinate, direction)
    next_dir = next_direction(direction)
    next_coord = next_coordinate(coordinate, next_dir)
    if value_at(next_coord) > 0
      return next_coordinate(coordinate, direction), direction
    else
      return next_coord, next_dir
    end
  end

  def value_at(coordinate)
    value[coordinate[0]][coordinate[1]]
  end

  def next_coordinate(coordinate, direction)
    [coordinate[0] + direction[0], coordinate[1] + direction[1]]
  end

  def next_direction(direction)
    case direction
    when [-1, 0]
      return [0, 1]
    when [0, 1]
      return [1, 0]
    when [1, 0]
      return [0, -1]
    when [0, -1]
      return [-1, 0]
    else
      raise NotImplementedError
    end
  end

  def print
    puts
    value.each do |row|
      puts row.join("\t")
    end
  end

  def diagonal_sum
    sum = 0
    (0..(n-1)).each do |k|
      sum += value[k][k]
      if k != (n - 1) / 2
        sum += value[k][n - 1 - k]
      end
    end
    sum
  end
end