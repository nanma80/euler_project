class Game
  attr_reader :hands, :input_string

  def initialize(input_string)
    @hands = []
    @hands << Hand.new(input_string[0..13])
    @hands << Hand.new(input_string[15..-1])
    @input_string = input_string
  end

  def scores
    @scores ||= @hands.map(&:score)
  end

  def player_1_wins?
    s1 = scores.first
    s2 = scores.last

    (0..(s1.length)).each do |i|
      if s1[i] > s2[i]
        return true
      elsif s1[i] < s2[i]
        return false
      end
    end
    raise "Tie? #{input_string}"
  end
end
