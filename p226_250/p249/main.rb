require '../../common'
require 'benchmark'

def brute_force(limit)
  count = 0
  primes = Prime::Cache.new(limit).primes
  prime_cache = Prime::Cache.new(limit * primes.length)
  generator_limit = 2 ** (primes.length)

  numbers = []

  generator_limit.times do |generator|
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

def subset_count(primes, sum)
  display_mod = 10 ** 16
  counts = {0 => 1}
  primes.each_with_index do |prime, index|
    puts prime if index % 30 == 0

    break if prime > sum
    new_counts = Hash.new { |hash, key| hash[key] = 0 }
    counts.each do |previous_sum, count|
      new_counts[previous_sum] = (new_counts[previous_sum] + count) % display_mod
      new_sum = previous_sum + prime
      if new_sum <= sum
        new_counts[new_sum] = (new_counts[new_sum] + count) % display_mod
      end
    end
    counts = new_counts
  end
  counts
end

def count(limit)
  display_mod = 10 ** 16
  prime_cache = Prime::Cache.new(limit)
  primes = prime_cache.primes
  prime_sum = primes.inject(:+)

  primes_as_sum = Prime::Cache.new(prime_sum).primes
  
  counts = subset_count(primes, prime_sum)

  total = 0
  primes_as_sum.each do |prime_as_sum|
    total = (total + counts[prime_as_sum] || 0) % display_mod
  end
  total
end

def main
  limit = 5000
  
  p count(limit)
  # p brute_force(limit)
end

puts Benchmark.measure { main }
