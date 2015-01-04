class Grid
  attr_reader :id, :constraints
  LIMIT = 30

  def initialize(id, cells)
    @id = id
    @cells = cells
    @constraints = constraints
  end

  def signature
    digits = []
    (0..2).each do |y|
      digits << @cells[0][y].value.to_s
    end
    digits.join.to_i
  end

  def solved?
    each_cell do |cell|
      if not cell.determined?
        return false
      end
    end
    true
  end

  def cell_values
    @cells.map do |row|
      row.map do |c|
        c.value
      end
    end
  end

  def fork
    fewest_possibilities = 10
    forking_cell = nil
    each_cell do |cell|
      possibility_count = cell.possible_values.length
      if possibility_count > 1 && possibility_count < fewest_possibilities
        fewest_possibilities = cell.possible_values.length
        forking_cell = cell
      end
    end

    children = []
    forking_cell.possible_values.each do |possible_value|
      new_cells = Marshal.load(Marshal.dump(cell_values))
      new_cells[forking_cell.x][forking_cell.y] = possible_value
      cells = []
      new_cells.each_with_index do |row, x|
        cell_row = []
        row.each_with_index do |cell_value, y|
          cell_row << Cell.new(x, y, cell_value)
        end
        cells << cell_row
      end
      children << Grid.new(id, cells)
    end
    children
  end

  def solve
    old_snapshot = nil
    new_snapshot = snapshot
    LIMIT.times do |iteration|
      if solved?
        return 'solved', iteration, self
      elsif old_snapshot == new_snapshot
        children = fork
        children.each do |child|
          (state, new_iteration, current_grid) = child.solve
          if state == 'solved'
            return 'solved', iteration + new_iteration, current_grid
          end
        end
        return 'stuck', iteration, self
      else
        begin
          update
        rescue ContradictionError
          return 'contradiction', iteration, self
        end
        old_snapshot = new_snapshot
        new_snapshot = snapshot
      end
    end
    return 'ongoing', LIMIT, self
  end

  def snapshot
    @cells.map do |row|
      row.map do |c|
        c.possible_values
      end
    end.to_s
  end

  def to_s
    header = "<Grid id: #{id}>\n"
    serialized_grid = @cells.map do |row|
      row.map do |c|
        c.value.to_s
      end.join(' ')
    end.join("\n")
    header + serialized_grid
  end

  def each_cell
    @cells.each do |row|
      row.each do |c|
        yield c
      end
    end
  end

  def update
    each_cell do |cell|
      cell.update
    end
  end

  def constraints
    (row_constraints + column_constraints + block_constraints).map {|c| Constraint.new(c)}
  end

  def row_constraints
    @cells
  end

  def column_constraints
    @cells.transpose
  end

  def block_constraints
    blocks = {}
    each_cell do |cell|
      block_id = cell.block_id
      blocks[block_id] = [] unless blocks[block_id]
      blocks[block_id] << cell
    end
    blocks.values
  end
end