require '../../common'
require 'benchmark'

def main
  # limit = 5 * (10 ** 5)
  limit = 10 ** 4
  prime_limit = (limit * 1.42).to_i
  prime_cache = Prime::Cache.new(prime_limit)
  primes = prime_cache.primes.select {|prime| prime % 8 == 1 || prime % 8 == 7}
  puts "cache finished"

  count = 0
  (2..limit).each do |n|
    puts 100 * n / limit if n % (10 ** 4) == 0
    t = 2 * n * n - 1
    sqrt_t = Math.sqrt(t).to_i
    is_prime = true
    primes.each do |prime|
      break if prime > sqrt_t
      if t % prime == 0
        is_prime = false
        break
      end
    end

    if is_prime
      count += 1
      # p n
    end
  end

  p count
end

p Benchmark.measure { main }