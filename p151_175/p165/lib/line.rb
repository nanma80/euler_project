class Line
  attr_reader :endpoints
  
  def initialize(endpoint_coordinates)
    @endpoints = endpoint_coordinates.map{|coordinates| Point.new(coordinates)}
  end

  def self.generate(line_count)
    lines = []
    coordinates = []
    seed = 290797
    (line_count * 4).times do
      seed = (seed * seed) % 50515093
      coordinates << seed % 500
      if coordinates.length == 4
        lines << Line.new([[coordinates[0], coordinates[1]], [coordinates[2], coordinates[3]]])
        coordinates = []
      end
    end
    lines
  end


  def x1
    @endpoints[0].x
  end

  def x2
    @endpoints[1].x
  end

  def y1
    @endpoints[0].y
  end

  def y2
    @endpoints[1].y
  end

  def intersect(other_line)
    matrix_a = x1 - x2
    matrix_b = other_line.x2 - other_line.x1
    matrix_c = y1 - y2
    matrix_d = other_line.y2 - other_line.y1

    delta = matrix_a * matrix_d - matrix_b * matrix_c
    if delta == 0
      # puts 'parallel'
      return nil
    end

    right_side_1 = other_line.x2 - x2
    right_side_2 = other_line.y2 - y2

    lambdas = [
      matrix_d * right_side_1 - matrix_b * right_side_2,
      - matrix_c * right_side_1 + matrix_a * right_side_2
    ].map{|v| v / delta}

    # p lambdas
    lambdas.each do |lambda|
      if lambda <= 0 || lambda >= 1
        # puts 'only if extended'
        return nil
      end
    end
    lambda1 = lambdas[0]
    lambda2 = lambdas[1]
    intersection1 = [lambda1 * x1 + (1 - lambda1) * x2, lambda1 * y1 + (1 - lambda1) * y2]
    intersection2 = [lambda2 * other_line.x1 + (1 - lambda2) * other_line.x2, lambda2 * other_line.y1 + (1 - lambda2) * other_line.y2]

    # p intersection1
    # p intersection2
    Point.new(intersection1)
  end
end