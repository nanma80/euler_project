class Board
  attr_reader :width, :height, :array, :size, :first_empty_index, :duplicate_factor

  def initialize(width, height)
    @width = width
    @height = height

    @array = []
    height.times { @array << [false] * width }
    @size = height * width
    @first_empty_index = 0
    @duplicate_factor = 1

    raise "Size #{size} not divisible by 3" unless size % 3 == 0
  end

  def increase_duplicate_factor(increment)
    @duplicate_factor += increment
  end

  def clone
    Marshal.load(Marshal.dump(self))
  end

  def completed?
    @first_empty_index >= @size
  end

  def fit?(piece)
    col_index = @first_empty_index % width
    row_index = @first_empty_index / width

    piece.cells.each do |cell|
      x = col_index + cell[0]
      y = row_index + cell[1]
      if x < 0 || x >= width
        return false
      elsif y < 0 || y >= height
        return false
      elsif @array[y][x]
        return false
      end
    end
    true
  end

  def place!(piece)
    col_index = @first_empty_index % width
    row_index = @first_empty_index / width

    piece.cells.each do |cell|
      x = col_index + cell[0]
      y = row_index + cell[1]
      
      @array[y][x] = true
    end
    
    until @first_empty_index == @size || !@array[row_index][col_index]
      @first_empty_index += 1
      col_index = @first_empty_index % width
      row_index = @first_empty_index / width
    end
  end

  def signature
    to_s + @first_empty_index.to_s
  end

  def to_s
    output = ''
    array.each do |row|
      output << row.inspect
      output << "\n"
    end

    output << "\n"
    output
  end
end
