class Piece
  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def self.all
    collection = []

    collection << Piece.new([[0, 0], [1, 0], [0, 1]])
    collection << Piece.new([[0, 0], [1, 0], [1, 1]])
    collection << Piece.new([[0, 0], [0, 1], [1, 1]])
    collection << Piece.new([[0, 0], [0, 1], [-1, 1]])
    collection << Piece.new([[0, 0], [0, 1], [0, 2]])
    collection << Piece.new([[0, 0], [1, 0], [2, 0]])

    collection
  end
end
