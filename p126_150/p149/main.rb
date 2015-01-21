require './p149'

def sequence(limit)
  sequence = []
  (1..55).each do |k|
    s = ((100003 - 200003 * k + 300007 * (k ** 3)) % 1000000) - 500000
    sequence << s
  end

  (56..(limit ** 2)).each do |k|
    s = ((sequence[k - 24 - 1] + sequence[k - 55 - 1] + 1000000) % 1000000) - 500000
    sequence << s
  end

  sequence
end

limit = 2000
matrix = []
limit.times do
  matrix << [0] * limit
end

sequence(limit).each_with_index do |value, index|
  x_index = index % limit
  y_index = index/limit
  matrix[x_index][y_index] = value
end
puts 'Matrix ready'

mat = Matrix.new(matrix)
p mat.max_sum