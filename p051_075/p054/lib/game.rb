class Game
  attr_reader :hands

  def initialize(input_string)
    @hands = []
    @hands << Hand.new(input_string[0..13])
    @hands << Hand.new(input_string[15..-1])
  end

  def player_1_win?
    true
  end
end
