require './p128'

limit = 10 ** 4
board = Board.new(limit)

counter = 0
array = []
(1..limit).each do |n|
  if board.prime_count(n) == 3
    counter += 1
    array << n
    p [counter, n, board.value_to_coordinates[n]]

  end
end

p array