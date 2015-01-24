require 'pp'
require 'set'
require 'benchmark'
require '../../common'

class Agent
  attr_reader :size, :visited, :visited_states

  def initialize(size)
    @size = size
    @visited = Set.new
    @visited_states = Set.new
  end

  def each_concatenation_implementation(first_n, suffix)
    if first_n == 0
      yield suffix
      return
    end

    (1..first_n).to_a.reverse.each do |from|
      new_suffix = [(from..first_n).to_a.map {|i| i.to_s}.join.to_i] + suffix
      each_concatenation_implementation(from - 1, new_suffix) do |concat|
        yield concat
      end
    end
  end

  def each_concatenation
    each_concatenation_implementation(size, []) do |concat|
      yield concat
    end
  end

  def reachable_count
    iterate
    p visited
    puts 'Count:'
    p visited.length
    puts 'Sum:'
    p visited.inject(:+)
    visited.length
  end

  def compute(input, position_index, operator)
    changing_input = input.dup
    first_number = changing_input[position_index]
    second_number = changing_input[position_index + 1]
    result = 0

    case operator
    when 0
      result = first_number + second_number
    when 1
      result = first_number - second_number
    when 2
      result = first_number * second_number
    when 3
      return nil if second_number == 0
      result = 1.0 * first_number / second_number
    end
    
    changing_input[position_index] = result
    changing_input.delete_at(position_index + 1)
    changing_input
  end

  def iterate
    each_concatenation do |concat|
      p concat
      operation_count = concat.length - 1

      to_process = [concat]
      (1..operation_count).to_a.reverse.each do |position_range|
        p position_range
        new_to_process = []
        to_process.each do |to_process_state|
          position_range.times do |position_index|
            4.times do |operation|
              outcome = compute(to_process_state, position_index, operation)
              next if outcome.nil?
              next if visited_states.include?(outcome)
              new_to_process << outcome
              visited_states << outcome
            end
          end
        end
        to_process = new_to_process
      end

      to_process.each do |final_state|
        raise if final_state.length != 1
        number = final_state.first
        next if number <= 0
        number_int = (number + 0.5 - 0.000001).to_i
        next if number_int != number
        visited << number_int
      end
    end
  end
end

def main
  agent = Agent.new(8)
  p agent.reachable_count
end

p Benchmark.measure { main }