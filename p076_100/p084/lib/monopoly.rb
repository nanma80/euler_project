class Monopoly
  attr_reader :board

  def initialize
    @board = [
      :go, :a1, :cc1, :a2, :t1, :r1, :b1, :ch1, :b2, :b3, 
      :jail, :c1, :u1, :c2, :c3, :r2, :d1, :cc2, :d2, :d3,
      :fp, :e1, :ch2, :e2, :e3, :r3, :f1, :f2, :u2, :f3,
      :g2j, :g1, :g2, :cc3, :g3, :r4, :ch3, :h1, :t2, :h2
    ]
  end

  def board_size
    @board_size ||= @board.length
  end

  def name(index)
    @board[index]
  end

  def index(name)
    board.index(name)
  end

  def code(name)
    "%.2d" % index(name)
  end

  def rails
    @rails ||= board.select {|name| name.to_s.start_with?('r')}.map{|name| index(name)}
  end

  def utilities
    @utilities ||= board.select {|name| name.to_s.start_with?('u')}.map{|name| index(name)}
  end

  def next_one(positions, current)
    first_attempt = positions.find {|position| position > current}
    if first_attempt.nil?
      positions.first
    else
      first_attempt
    end
  end

  def next_rail(current)
    next_one(rails, current)
  end

  def next_utility(current)
    next_one(utilities, current)
  end

  def move(current, offset)
    (current + offset) % board.length
  end

  def adjust(current)
    probabilities = {}
    case name(current)
    when :g2j
      { index(:jail) => 1.0 }
    when :cc1, :cc2, :cc3
      { 
        index(:go) => 1.0 / 16, 
        index(:jail) => 1.0 / 16,
        current => 14.0 / 16
      }
    when :ch1, :ch2, :ch3
      {
        index(:go) => 1.0 / 16,
        index(:jail) => 1.0 / 16,
        index(:c1) => 1.0 / 16,
        index(:e3) => 1.0 / 16,
        index(:h2) => 1.0 / 16,
        index(:r1) => 1.0 / 16,
        next_rail(current) => 2.0 / 16,
        next_utility(current) => 1.0 / 16,
        move(current, -3) => 1.0 / 16,
        current => 6.0 / 16
      }
    else
      { current => 1.0 }
    end
  end

  def transition(start_position, dice)
    arriving_prob = {}
    dice.probabilities.each do |offset, prob|
      current = move(start_position, offset)
      adjust(current).each do |first_adjust, first_adjust_prob|
        arriving_prob[first_adjust] = 
        (arriving_prob[first_adjust] || 0) + prob * first_adjust_prob
      end
    end
    arriving_prob
  end

  def zero_matrix(size)
    matrix = []
    size.times do |end_position|
      matrix << ([0] * size)
    end
    matrix
  end

  def transition_matrix(dice)
    return @transition_matrix unless @transition_matrix.nil?

    @transition_matrix = zero_matrix(board_size)
    board_size.times do |start_position|
      transition(start_position, dice).each do |end_position, prob|
        @transition_matrix[end_position][start_position] += prob
      end
    end
    @transition_matrix
  end

end
