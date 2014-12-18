class LoaderBuffer
  def initialize
    @buffer = []
  end

  def << line
    @buffer << line
  end

  def full?
    @buffer.length >= 10
  end

  def id
    @buffer[0][5..6].to_i
  end

  def raw_data
    @buffer[1..9].map do |row|
      row.split('').map do |cell|
        cell.to_i
      end
    end
  end

  def grid
    cells = []
    raw_data.each_with_index do |row, x|
      cell_row = []
      row.each_with_index do |cell, y|
        cell_row << Cell.new(x, y, cell)
      end
      cells << cell_row
    end
    Grid.new(id, cells)
  end
end
