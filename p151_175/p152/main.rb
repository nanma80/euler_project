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

    branching_index = greatest_prime_factor
    until input_state[branching_index].nil?
      branching_index += greatest_prime_factor
      if branching_index > limit
        return
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
          puts "Found: #{print(candidate) + [input_state_with_sums.first.length]}"
          @solutions << print(candidate)
          return
        elsif new_current_sum > target
          next
        end
      else
        new_max_possible -= Rational(1, branching_index * branching_index)
        if new_max_possible < target
          next
        end
      end

      yield [candidate, new_current_sum, new_max_possible]
    end
  end
end

def count_given_last(last)
  limit = last - 1

  target = Rational(1, 2) - Rational(1, last * last)
  primes = Prime::Cache.new(last).primes

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
  counter = 0
  until states.empty?
    counter += 1
    if counter % 1_000_000 == 0
      puts "Queue length: #{states.length}. Number of states visited: #{counter}"
    end
    state = states.pop
    agent.each_candidate(state, target, primes) do |candidate|
      states << candidate
    end
  end

  agent.solutions.length
end

def main
  limit = 55
  total = 0
  (3..limit).each do |last|
    puts "Last number: #{last}"
    total += count_given_last(last)
  end
  p total
end

puts Benchmark.measure { main }
