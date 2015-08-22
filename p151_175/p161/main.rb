require 'pp'
require 'set'
require './p161'

count = 0

empty_board = Board.new(9, 12)
pieces = Piece.all

generation = {}
generation[empty_board.signature] = empty_board

(empty_board.size / 3).times do |piece_count|
  p [piece_count, generation.length]

  new_generation = {}
  generation.each do |_array, board|
    pieces.each do |piece|
      if board.fit?(piece)
        new_board = board.clone
        new_board.place!(piece)
        if new_board.completed?
          # puts new_board.duplicate_factor
          count += new_board.duplicate_factor
        else
          array = new_board.signature
          if new_generation[array].nil?
            new_generation[array] = new_board
          else
            new_generation[array].increase_duplicate_factor(new_board.duplicate_factor)
          end
        end
      end
    end
  end

  generation = new_generation
end

p count