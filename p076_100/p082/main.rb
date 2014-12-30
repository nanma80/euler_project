require 'pp'

filename = 'test_matrix.txt'
filename = 'p082_matrix.txt'

def empty_matrix(row_count, column_count)
  min_path_sum = []
  row_count.times do
    min_path_sum << [nil] * column_count
  end
  min_path_sum
end


matrix = []
File.open(filename).each do |line|
  row = line.chomp.split(',').map(&:to_i)
  matrix << row
end

row_count = matrix.length
column_count = matrix.first.length

min_path_sum = empty_matrix(row_count, column_count)

iteration_count = row_count

iteration_count.times do
  column_count.times do |column_index|
    row_count.times do |row_index|
      current = matrix[row_index][column_index]
      candidates = []
      if column_index == 0
        candidates << 0
      else
        candidates << min_path_sum[row_index][column_index - 1]
      end

      if row_index > 0
        candidates << min_path_sum[row_index - 1][column_index]
      end

      if row_index < row_count - 1
        candidates << min_path_sum[row_index + 1][column_index]
      end

      minimum = nil
      candidates.each do |candidate|
        next if candidate.nil?
        value = candidate + current
        if minimum.nil? || value < minimum
          minimum = value
        end
      end
      min_path_sum[row_index][column_index] = minimum
    end
  end
end

p min_path_sum.transpose.last.min
