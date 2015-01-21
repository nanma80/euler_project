class Matrix
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def each_line
    length = matrix.length
    matrix_transpose = matrix.transpose
    length.times do |index|
      yield matrix[index]
      yield matrix_transpose[index]
    end

    (-(length - 1)..(length - 1)).each do |offset|
      diagonal = []
      anti_diagonal = []
      length.times do |x_index|
        y_index = x_index + offset
        if y_index >= 0 && y_index < length
          diagonal << matrix[x_index][y_index]
          anti_diagonal << matrix[x_index][length - 1 - y_index]
        end
      end
      yield diagonal
      yield anti_diagonal
    end
  end

  def max_sum
    max_so_far = 0
    each_line do |line|
      print '.'
      current_max = line.max_sum
      if current_max > max_so_far
        max_so_far = current_max
      end
    end
    max_so_far
  end
end
