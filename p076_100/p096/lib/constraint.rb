class Constraint
  attr_reader :cells
  
  def initialize(cells)
    @cells = cells
  end

  def violated?
    
  end

  def to_s
    "<Constraint #{cells.join(' ')}>"
  end
end