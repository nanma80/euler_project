class ContradictionError < StandardError
end

class Cell
  attr_reader :x, :y, :value, :possible_values, :constraints

  def initialize(x, y, value)
    @x = x
    @y = y
    @value = value
    @constraints = []

    if value != 0
      @possible_values = [value]
    else
      @possible_values = (1..9).to_a
    end
  end

  def block_id
    [ x/3, y/3 ].to_s
  end

  def to_s
    value.to_s
  end

  def add_constraint(constraint)
    @constraints << constraint
  end

  def update
    return unless determined?
    
    constraints.each do |constraint|
      constraint.cells.each do |other_cell|
        next if other_cell == self
        other_cell.eliminate_possibility(value)
      end
    end
  end

  def eliminate_possibility(value)
    @possible_values.delete(value)
    if determined?
      @value = @possible_values.first
    end

    if contradiction?
      raise ContradictionError, "cell #{x}, #{y}"
    end
  end

  def determined?
    @possible_values.length == 1
  end

  def contradiction?
    @possible_values.length == 0
  end
end
