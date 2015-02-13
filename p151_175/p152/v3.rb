require 'set'
require 'pp'
require 'benchmark'
require '../../common'

class Agent
  attr_reader :count, :timer, :factors_cache, :solutions

  def initialize
    @timer = [0.0, 0.0, 0.0]
    @factors_cache = {}
    @solutions = Set.new
  end

  def greatest_factor(number, primes)
    return @factors_cache[number] unless @factors_cache[number].nil?
    original_number = number
    factors = []
    primes.each do |prime|
      if number % prime == 0
        factors << prime
      end

      while number % prime == 0
        number /= prime
      end

      break if number == 1
    end
    
    greatest_factor = factors.last
    @factors_cache[original_number] = greatest_factor
    greatest_factor
  end

  def print(state)
    true_indices = []
    state.each_with_index do |s, index|
      true_indices << index if s == true
    end
    true_indices
  end

  def each_candidate(input_state_with_sums, target, primes)
    input_state = input_state_with_sums[0]
    current_sum = input_state_with_sums[1]
    max_possible = input_state_with_sums[2]
    limit = input_state.length - 1

    gap = target - current_sum
    gap_denominator = gap.denominator

    greatest_prime_factor = greatest_factor(gap_denominator, primes)

    if greatest_prime_factor == 2
      branching_index = 2
      until input_state[branching_index].nil?
        branching_index *= 2
        break if branching_index > limit
      end
      if branching_index > limit
        branching_index = 2
        until input_state[branching_index].nil?
          branching_index += 1
          if branching_index > limit
            return
          end
        end
      end
    else
      branching_index = greatest_prime_factor
      until input_state[branching_index].nil?
        branching_index += greatest_prime_factor
        if branching_index > limit
          return
        end
      end
    end

    [true, false].map do |new_state|
      candidate = input_state.dup
      candidate[branching_index] = new_state
      new_current_sum = current_sum
      new_max_possible = max_possible
      if new_state
        new_current_sum += Rational(1, branching_index * branching_index)
        if new_current_sum == target
          puts "Found: #{print(candidate)}"
          @solutions << print(candidate)
          return
        elsif new_current_sum > target
          next
        end
      else
        new_max_possible -= Rational(1, branching_index * branching_index)
        if new_max_possible < target
          return
        end
      end

      yield [candidate, new_current_sum, new_max_possible]
    end
  end
end

def main
  limit = 35
  iteration_count = limit

  target = Rational(1, 2)
  puts "Target: #{target}. Limit: #{limit}"
  primes = Prime::Cache.new(limit).primes

  agent = Agent.new
  original_state = [nil] * (limit + 1)
  [0, 1].each do |false_index|
    original_state[false_index] = false
  end
  current_sum = Rational(0, 1)
  max_possible = Rational(0, 1)
  (2..limit).each do |k|
    max_possible += Rational(1, k * k)
  end

  states = [[original_state, current_sum, max_possible]]
  tick = Time.new
  iteration_count.times do |iteration|
    tock = Time.new
    puts "#{iteration}\t#{states.length}\t#{tock - tick}"
    tick = tock
    break if states.empty?

    new_states = []
    states.each do |state|
      agent.each_candidate(state, target, primes) do |candidate|
        new_states << candidate
      end
    end

    states = new_states
  end

  puts "Solutions:" 
  agent.solutions.each do |solution|
    puts solution.inspect
  end
  
  puts "Solution count: #{agent.solutions.length}"
end

puts Benchmark.measure { main }
