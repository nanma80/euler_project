require 'pp'
require 'set'
require 'benchmark'
require '../../common'

class Agent
  attr_reader :size, :visited

  def initialize(size)
    @size = size
    @visited = Set.new
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
    p visited.inject(:+)
    visited.length
  end

  def iterate
    each_concatenation do |concat|
      p concat
      operation_count = concat.length - 1
      position_generator_limit = operation_count.factorial
      operation_generator_limit = 4 ** operation_count
      position_generator_limit.times do |position_generator|
        if position_generator_limit > 10 ** 2 && position_generator % 30 == 0
          puts "#{position_generator}/#{position_generator_limit}"
        end
        operation_generator_limit.times do |operation_generator|
          indices = indices(operation_count, position_generator)
          operators = operators(operation_count, operation_generator)
          number = evaluate(concat, indices, operators)
          next if number.nil?
          next if number <= 0
          number_int = (number + 0.5 - 0.000001).to_i
          next if number_int != number
          visited << number_int
        end
      end
    end
  end

  def evaluate(concat, indices, operators)
    changing_concat = concat.dup
    path = []
    operators.each_with_index do |operator, operation_index|
      path << changing_concat.dup
      position_index = indices[operation_index]
      first_number = changing_concat[position_index]
      second_number = changing_concat[position_index + 1]
      result = 0

      case operator
      when 0
        result = first_number + second_number
      when 1
        result = first_number - second_number
      when 2
        result = first_number * second_number
      when 3
        if second_number == 0
          return nil
        end
        result = 1.0 * first_number / second_number
      end
      
      changing_concat[position_index] = result
      changing_concat.delete_at(position_index + 1)
    end

    changing_concat.first
  end

  def indices(operation_count, generator)
    indices = []
    (1..operation_count).to_a.reverse.each do |mod|
      indices << (generator % mod)
      generator /= mod
    end
    indices
  end

  def operators(operation_count, generator)
    operators = []
    operation_count.times do
      operators << generator % 4
      generator /= 4
    end
    operators
  end
end

def main
  agent = Agent.new(6)
  p agent.reachable_count
end

p Benchmark.measure { main }