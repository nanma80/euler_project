require '../../common'
require 'benchmark'

def brute_force(limit)
  count = 0
  primes = Prime::Cache.new(limit).primes
  prime_cache = Prime::Cache.new(limit * primes.length)
  generator_limit = 2 ** (primes.length)

  numbers = []

  generator_limit.times do |generator|
    # if generator % 10000 == 0
    #   puts "#{generator}/#{generator_limit}"
    # end

    inclusion = (generator_limit + generator).to_s(2)[1..-1].split('').map{|c| c == '1'}
    sum = 0
    primes.each_with_index do |prime, index|
      sum += prime if inclusion[index]
    end
  
    numbers << sum
    if prime_cache.is_prime?(sum)
      count += 1
    end
  end
  # p numbers
  count
end

def each_array(primes, count, limit, start_index = 0)
  if count == 0 || start_index >= primes.length
    return yield []
  end

  each_array(primes, count, limit, start_index + 1) do |array|
    # if array.inject(1){|m, v| m * v} <= limit
      yield array
    # end
  end

  each_array(primes, count - 1, limit, start_index + 1) do |array|
    new_array = [primes[start_index]] + array
    if new_array.inject(:*) <= limit
      yield new_array
    end
  end
end

def all_mods(inputs)
  input_sum = inputs.inject(:+)
  mod_limit = Math.sqrt(input_sum).to_i
  mod_prime_count = 0
  # mod_limit = inputs.inject(:+)
  prime_cache = Prime::Cache.new(mod_limit)
  primes = prime_cache.primes
  p primes
  output = {}
  
  each_array(primes, 4, input_sum) do |array|
    next if array.empty?
    mod = array.inject(:*)
    output[mod] = ((array.length % 2) == 1) ? 1 : -1

    p [array, output[mod]]

    sum = array.inject(:+)
    if sum <= mod_limit && prime_cache.is_prime?(sum)
      mod_prime_count += 1
      # puts "#{sum} is prime"
    end
  end

  return output, mod_prime_count
end

def count(limit)
  display_mod = 10 ** 16
  prime_cache = Prime::Cache.new(limit)
  primes = prime_cache.primes

  (all_mods, mod_prime_count) = all_mods(primes)

  mod_range = all_mods.keys

  puts "limit: #{limit}\tprimes count: #{primes.length}\tmod count: #{mod_range.length}"

  counts = {}
  mod_range.each do |mod|
    counts[mod] = [0] * mod
    counts[mod][0] = 1
  end

  p primes

  primes.each do |prime|
    new_counts = {}
    mod_range.each do |mod|
      new_counts[mod] = [0] * mod
      mod.times do |new_remainder|
        old_remainder = (new_remainder - prime) % mod
        new_counts[mod][new_remainder] = (counts[mod][new_remainder] + counts[mod][old_remainder]) % display_mod
      end
    end
    counts = new_counts
    # p [prime, counts]
  end

  # p counts

  divisible_counts = {}
  counts.each do |mod, remainder_counts|
    divisible_counts[mod] = remainder_counts[0]
  end  
  p divisible_counts

  divisible_total = 0
  all_mods.each do |mod, sign|
    # p sign * divisible_counts[mod]
    divisible_total += sign * divisible_counts[mod]
  end
  p divisible_total

  count = (2.mod_pow(primes.length, display_mod) - divisible_total + mod_prime_count) % display_mod
  count
end

def main
  # limit = 10
  limit = 31
  
  p count(limit)
  p brute_force(limit)
end

puts Benchmark.measure { main }
