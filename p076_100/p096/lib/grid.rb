class Grid
  attr_reader :id, :cells, :constraints

  def initialize(id, cells)
    @id = id
    @cells = cells
    @constraints = constraints
  end

  def solvable?
  end

  def solved?
  end

  def to_s
    header = "<Grid id: #{id}>\n"
    serialized_grid = @cells.map do |row|
      row.map do |c|
        c.value.to_s
      end.join(' ')
    end.join("\n")

    serialized_constraints = @constraints.map do |constraint|
      constraint.to_s
    end.join("\n")

    header + serialized_grid + "\n" + serialized_constraints + "\n"
  end

  def each_cell
    @cells.each do |row|
      row.each do |c|
        yield c
      end
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