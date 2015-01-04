class Constraint
  attr_reader :cells
  
  def initialize(cells)
    @cells = cells
    cells.each do |cell|
      cell.add_constraint(self)
    end
  end

  def violated?
    
  end

  def to_s
    "<Constraint #{cells.join(' ')}>"
  end
end