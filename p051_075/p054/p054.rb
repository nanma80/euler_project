require './lib/card'
require './lib/hand'
require './lib/game'

filename = 'p054_poker.txt'
count = 0

File.open(filename).each do |line|
  game = Game.new(line.chomp)
  if game.player_1_wins?
    count += 1
  end
end

p count

