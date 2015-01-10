require 'pp'

class Agent
  def initialize
    @cache = {}
  end

  def max_sum(matrix)
    return @cache[matrix] unless @cache[matrix].nil?

    dimension = matrix.length
    if dimension == 1
      return matrix.first.first
    end

    max_sum = 0
    dimension.times do |row_index|
      sum = matrix[row_index][0]
      sub_matrix = []
      dimension.times do |sub_matrix_row_index|
        next if sub_matrix_row_index == row_index
        sub_matrix << matrix[sub_matrix_row_index][1..-1]
      end
      sum += max_sum(sub_matrix)

      if sum > max_sum
        max_sum = sum
      end
    end
    @cache[matrix] = max_sum
    max_sum
  end
end

def matrix(testing)
  if testing
    filename = 'test_matrix.txt'
  else
    filename = 'matrix.txt'
  end

  output = []
  File.open(filename).each do |line|
    output << line.chomp.split(' ').map(&:to_i)
  end
  output
end

testing = false

matrix = matrix(testing)

agent = Agent.new
p agent.max_sum(matrix)
