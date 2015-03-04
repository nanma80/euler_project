require 'set'

class State
  attr_reader :length
  attr_accessor :current

  def initialize(length)
    @length = length
    @current = random_state
  end

  def random_state
    state = []
    length.times do
      state << rand(10)
    end
    state
  end

  def each_neighbor
    length.times do |changing_index|
      10.times do |change_to|
        next if change_to == current[changing_index]
        new_state = current.dup
        new_state[changing_index] = change_to
        yield new_state
      end
    end
  end
end