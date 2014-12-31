class Dice
  # Always two dice. Each has @size sides
  attr_reader :size

  def initialize(size)
    @size = size
  end

  def probabilities
    return @probabilities unless @probabilities.nil?
    @probabilities = {}
    prob_each_case = 1.0 / size / size
    (1..size).each do |d1|
      (1..size).each do |d2|
        sum = d1 + d2
        @probabilities[sum] = (@probabilities[sum] || 0) + prob_each_case
      end
    end
    @probabilities
  end
end