require './p185'
require 'benchmark'
require 'pp'

def main
  # filename = 'test_data.txt'
  filename = 'data.txt'

  start_index = 253500000

  game = Game.new(filename)

  # puts game.solve
  puts game.try_solve(0.5, start_index)
end

# puts Benchmark.measure { main }

def random_solve
  # filename = 'test_data.txt'
  filename = 'data.txt'

  game = Game.new(filename)
  puts game.random_solve(5)
end

random_solve