require 'pp'
require 'benchmark'

class Board
  attr_reader :grid, :size

  def initialize(size, input_grid = nil)
    @size = size
    @grid = []
    if input_grid.nil?
      (size + 1).times do |row_index|
        if row_index == 0 || row_index == size
          row = [0] * (size + 1)
        else
          row = [0] + [nil] * (size - 1) + [0]
        end
        @grid << row
      end
    else
      input_grid.each do |row|
        @grid << row.dup
      end
    end
  end

  def complete?
    (first_nil.nil?) # can't find nil in grid
  end

  def first_nil
    @grid.each_with_index do |row, row_index|
      column_index = row.index(nil)
      unless column_index.nil?
        return [row_index, column_index]
      end
    end
    return nil # can't find nil in grid
  end

  def valid_candidates(row_index, column_index)
    candidates = (-size..size).to_a

    loops = [
      [
        [row_index + 1, column_index],
        [row_index + 1, column_index + 1],
        [row_index, column_index + 1]
      ],
      [
        [row_index - 1, column_index],
        [row_index - 1, column_index + 1],
        [row_index, column_index + 1]
      ],
      [
        [row_index + 1, column_index],
        [row_index + 1, column_index - 1],
        [row_index, column_index - 1]
      ],
      [
        [row_index - 1, column_index],
        [row_index - 1, column_index - 1],
        [row_index, column_index - 1]
      ]
    ]

    loops.each do |loop_nodes|
      loop_values = []
      diagonal_value = nil
      neighbor_values = []
      loop_nodes.each_with_index do |neighbor_coord, loop_index|
        neighbor_row_index = neighbor_coord[0]
        neighbor_column_index = neighbor_coord[1]
        next if grid[neighbor_row_index].nil?
        neighbor_value = grid[neighbor_row_index][neighbor_column_index]
        next if neighbor_value.nil?
        candidates.select! {|value| (value - neighbor_value).abs <= 1}
        loop_values << neighbor_value
        if loop_index == 1
          diagonal_value = neighbor_value
        else
          neighbor_values << neighbor_value
        end
      end
      loop_values.sort!
      if loop_values[0] == loop_values[1] && loop_values[0] == loop_values[2]
        candidates.delete(loop_values[0])
      end

      unless diagonal_value.nil?
        if neighbor_values[0] == neighbor_values[1] && neighbor_values[1] != diagonal_value
          candidates.delete(diagonal_value)
        end
      end
    end

    candidates
  end
end

def main
  size = 6
  queue = [ Board.new(size) ]
  
  count = 10 ** 8
  count.times do |count_index|
    board_to_process = queue[0]
    nil_coord = board_to_process.first_nil
    if nil_coord.nil?
      puts "Finished"
      break
    end

    if count_index % 10000 == 0
      p [count_index, queue.length, nil_coord]
    end

    queue.delete_at(0)
    candidates = board_to_process.valid_candidates(nil_coord[0], nil_coord[1])
    # p candidates
    grid = board_to_process.grid
    candidates.each do |candidate|
      grid[nil_coord[0]][nil_coord[1]] = candidate
      queue << Board.new(size, grid)
    end
  end

  # pp queue
  p queue.length
end

p Benchmark.measure { main }

# board = Board.new(5)
# pp board.first_nil


