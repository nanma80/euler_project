class Board
  attr_reader :array, :length

  def initialize(array)
    @length = array.length
    if @length % 2 != 0
      raise "Invalid array length #{@length}"
    end
    @array = array
  end

  def lines
    return @line unless @line.nil?

    @lines = []
    start_index = 0
    while start_index < array.length
      @lines << [array[start_index], array[start_index + 1], array[(start_index + 3) % length]]
      start_index += 2
    end
    @lines
  end

  def sums
    @sums ||= lines.map { |line| line.inject(:+) }
  end

  def magic?
    sums.uniq.length == 1
  end

  def signature
    min_index = nil
    min_external = nil
    lines.each_with_index do |line, index|
      external = line.first
      if min_external.nil? || external < min_external
        min_index = index
        min_external = external
      end
    end

    if min_index == 0
      rotated_lines = lines
    else
      rotated_lines = (lines[min_index..-1] + lines[0..min_index - 1])
    end

    rotated_lines.map do |line|
      line.map(&:to_s).join
    end.join.to_i
  end
end

max_signature = nil

(1..9).to_a.permutation do |perm|
  board = Board.new([10] + perm)
  if board.magic?
    signature = board.signature
    if max_signature.nil? || max_signature < signature
      max_signature = signature
    end
  end
end

p max_signature
# p Board.new([6, 2, 5, 1, 4, 3]).string
