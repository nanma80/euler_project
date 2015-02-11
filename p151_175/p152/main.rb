require 'set'
require 'pp'
require 'benchmark'
require '../../common'

@count = 0

def factors(number, primes)
  output = []
  primes.each do |prime|
    if number % prime == 0
      output << prime
    end

    while number % prime == 0
      number /= prime
    end

    break if number == 1
  end
  output
end

def print(state)
  true_indices = []
  state.each_with_index do |s, index|
    true_indices << index if s == true
  end
  true_indices
end

def candidates(input_state_with_sums, target, primes)
  input_state = input_state_with_sums[0]
  current_sum = input_state_with_sums[1]
  max_possible = input_state_with_sums[2]
  limit = input_state.length - 1

  if current_sum == target
    puts "Found: #{print(input_state)}"
    @count += 1
    return []
  end

  if max_possible < target
    return []
  end

  gap = target - current_sum
  gap_denominator = gap.denominator

  greatest_prime_factor = factors(gap_denominator, primes).last

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
          return []
        end
      end
    end
  else
    branching_index = greatest_prime_factor
    until input_state[branching_index].nil?
      branching_index += greatest_prime_factor
      if branching_index > limit
        return []
      end
    end
  end

  return [true, false].map do |new_state|
    candidate = input_state.dup
    candidate[branching_index] = new_state
    new_current_sum = current_sum
    if new_state
      new_current_sum += Rational(1, branching_index * branching_index)
    end

    new_max_possible = max_possible
    if !new_state
      new_max_possible -= Rational(1, branching_index * branching_index)
    end
    [candidate, new_current_sum, new_max_possible]
  end
end

def main
  limit = 35
  iteration_count = limit

  target = Rational(1, 2)
  primes = Prime::Cache.new(limit).primes

  original_state = [nil] * (limit + 1)
  [0, 1].each do |false_index|
    original_state[false_index] = false
  end
  current_sum = Rational(0, 1)
  max_possible = Rational(0, 1)
  (2..limit).each do |k|
    max_possible += Rational(1, k * k)
  end

  states = Set.new([[original_state, current_sum, max_possible]])
  tick = Time.new
  iteration_count.times do |iteration|
    tock = Time.new
    puts "#{iteration}\t#{states.length}\t#{tock - tick}"
    tick = tock
    break if states.empty?

    new_states = Set.new
    states.each do |state|
      candidates = candidates(state, target, primes)
      candidates.each do |candidate|
        new_states << candidate
      end
    end

    states = new_states
  end

  puts "Solution count: #{@count}"
end

p Benchmark.measure { main }
