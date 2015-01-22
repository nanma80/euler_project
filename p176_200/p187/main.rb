require '../../common'
require 'benchmark'

def main
  limit = 10 ** 8
  prime_limit = limit / 2
  prime_cache = Prime::Cache.new(prime_limit)
  prime_count = []
  current_count = 0
  prime_check = prime_cache.prime_check
  (0..prime_limit + 1).each do |pointer|
    if prime_check[pointer]
      current_count += 1
    end
    prime_count << current_count
  end
  
  semiprime_count = 0
  prime_cache.primes.each do |prime|
    break if prime * prime >= limit
    semiprime_count += prime_count[limit / prime] - prime_count[prime - 1]
  end
  p semiprime_count
end

p Benchmark.measure { main }