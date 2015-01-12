require './p128'

limit = 10 ** 6
board = Board.new(limit)

counter = 0
(1..limit).each do |n|
  if board.prime_count(n) == 3
    counter += 1
    p [counter, n]
  end
end