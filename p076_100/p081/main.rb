require 'pp'

filename = 'test_matrix.txt'
filename = 'p081_matrix.txt'

matrix = []
File.open(filename).each do |line|
  row = line.chomp.split(',').map(&:to_i)
  matrix << row
end

row_count = matrix.length
column_count = matrix.first.length

min_path_sum = []
row_count.times do
  min_path_sum << [0] * column_count
end

row_count.times do |row_index|
  column_count.times do |column_index|
    current = matrix[row_index][column_index]
    candidates = []
    if row_index > 0
      candidates << min_path_sum[row_index - 1][column_index] + current
    end

    if column_index > 0
      candidates << min_path_sum[row_index][column_index - 1] + current
    end

    if candidates.empty?
      candidates << current
    end

    min_path_sum[row_index][column_index] = candidates.min
  end
end

p min_path_sum.last.last