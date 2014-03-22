def get_matrix
  filename = '.\p011\matrix.txt'
  matrix = []
  File.open(filename).each do |line|
    elements = line.chomp.split(' ')
    elements.map! do |number_string|
      number_string.to_i
    end
    matrix << elements
  end
  matrix
end

def each_line(n_rows, n_cols, size)
  horizontal_direction = [0, 1]
  vertical_direction = [1, 0]
  diagonal1_direction = [1, 1]
  diagonal2_direction = [1, -1]

  directions = [horizontal_direction, vertical_direction, diagonal1_direction, diagonal2_direction]

  directions.each do |direction|
    (0..(n_rows - 1)).each do |starting_row|
      (0..(n_cols - 1)).each do |starting_col|
        ending_row = starting_row + direction[0] * (size - 1)
        ending_col = starting_col + direction[1] * (size - 1)
        if ending_row >= 0 && ending_row < n_rows && ending_col >= 0 && ending_col < n_cols
          indices = []
          size.times do |position|
            indices << [starting_row + position * direction[0], starting_col + position * direction[1]]
          end
          yield indices
        end
      end
    end
  end
end

matrix = get_matrix
n_rows = matrix.length
n_cols = matrix[0].length
length_of_line = 4

max_product = 0
each_line(n_rows, n_cols, length_of_line) do |line|
  product = 1
  line.each do |coordinate|
    product *= matrix[coordinate[0]][coordinate[1]]
  end
  max_product = product if product > max_product
end

p max_product