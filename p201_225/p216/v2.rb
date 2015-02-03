require './modular_sqrt'
require 'benchmark'

def main
  limit = 10 ** 5
  # limit = 5 * (10 ** 7)
  prime_limit = (limit * Math.sqrt(2)).to_i
  prime_cache = Prime::Cache.new(prime_limit)
  primes = prime_cache.primes.select {|prime| prime % 8 == 1 || prime % 8 == 7}
  prime_length = primes.length
  puts "Primes cached. Length: #{prime_length}"


  is_prime_per_n = [true] * (limit + 1)
  [0, 1].each do |exception_index|
    is_prime_per_n[exception_index] = false
  end

  primes.each_with_index do |prime, prime_index|
    puts "#{prime_index}/#{prime_length}" if prime_index % (10 ** 4) == 0 || prime_index < 1000
    sqrt1 = modular_sqrt((prime + 1)/2, prime)
    [sqrt1, prime - sqrt1].each do |sqrt|
      raise "#{prime}'s sqrt is 0" if sqrt == 0
      if sqrt == 1
        sqrt += prime
      end
      
      while sqrt <= limit && (2 * sqrt * sqrt - 1 < prime)
        is_prime_per_n[sqrt] = false
        sqrt += prime
      end

      if (2 * sqrt * sqrt - 1 != prime)
        is_prime_per_n[sqrt] = false
      end
      sqrt += prime

      while sqrt <= limit
        is_prime_per_n[sqrt] = false
        sqrt += prime
      end
    end
  end

  count = 0
  is_prime_per_n.each_with_index do |is_prime, n|
    if is_prime
      count += 1
    end
  end

  p count
end

puts Benchmark.measure { main }
