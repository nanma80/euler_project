require 'pp'
require 'set'
require './p161'

count = 0

empty_board = Board.new(3, 3)
pieces = Piece.all

generation = {}
generation[empty_board.signature] = empty_board

(empty_board.size / 3).times do
  new_generation = {}
  generation.each do |_array, board|
    pieces.each do |piece|
      if board.fit?(piece)
        new_board = board.clone
        new_board.place!(piece)
        if new_board.completed?
          puts new_board.duplicate_factor
          count += new_board.duplicate_factor
        else
          array = new_board.signature
          if new_generation[array].nil?
            new_generation[array] = new_board
          else
            new_generation[array].increase_duplicate_factor
          end
        end
      end
    end
  end

  generation = new_generation
  generation.each do |a, b|
    puts a
    puts b.duplicate_factor
  end
end

p count