class Hand
  attr_reader :cards, :input_string

  def initialize(input_string)
    @cards = []
    input_string.split(' ').each do |card_string|
      @cards << Card.new(card_string)
    end
    @input_string = input_string
    raise "Not five cards for #{input_string}" if @cards.length != 5
  end

  def suits
    @suits ||= @cards.map(&:suit)
  end

  def numerics
    @numerics ||= @cards.map(&:numeric)
  end

  def flush?
    suits.uniq.length == 1
  end

  def straight?
    sorted_numerics = numerics.sort
    return true if sorted_numerics == [2, 3, 4, 5, 14]
    (0..3).each do |i|
      return false if sorted_numerics[i + 1] - sorted_numerics[i] != 1
    end
    true
  end

  def straight_flush?
    flush? && straight?
  end

  def royal_flush?
    flush? && straight? && numerics.include?(14) && numerics.include?(10)
  end

  def numerics_histogram
    return @numerics_histogram unless @numerics_histogram.nil?
    
    @numerics_histogram = {}
    numerics.each do |numeric|
      @numerics_histogram[numeric] = (@numerics_histogram[numeric] || 0) + 1
    end

    @numerics_histogram = @numerics_histogram.sort_by do |numeric, count|
      [ - count, - numeric]
    end
  end

  def numerics_counts
    @numerics_counts ||= numerics_histogram.map { |item| item.last }
  end

  def distinct_numerics
    @distinct_numerics ||= numerics_histogram.map { |item| item.first }
  end

  def four?
    numerics_counts == [4, 1]
  end

  def full_house?
    numerics_counts == [3, 2]
  end

  def pair?
    numerics_counts == [2, 1, 1, 1]
  end

  def two_pairs?
    numerics_counts == [2, 2, 1]
  end

  def three?
    numerics_counts == [3, 1, 1]
  end

  def high_card?
    numerics_counts == [1] * 5
  end

  def score
    score = []
    if royal_flush?
      score = [9]
    elsif straight_flush?
      score = [8]
    elsif four?
      score = [7]
    elsif full_house?
      score = [6]
    elsif flush?
      score = [5]
    elsif straight?
      score = [4]
    elsif three?
      score = [3]
    elsif two_pairs?
      score = [2]
    elsif pair?
      score = [1]
    elsif high_card?
      score = [0]
    else
      raise "What is this? #{input_string}"
    end

    if straight_flush? || straight?
      if numerics.include?(14) && numerics.include?(5)
        score << 5
      else
        score << distinct_numerics.max
      end
    else
      score += distinct_numerics
    end
  end
end