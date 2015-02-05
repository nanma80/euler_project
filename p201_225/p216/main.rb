require './special_modular_sqrt'
require 'benchmark'

# https://gist.github.com/burke/1688857
# export RUBY_GC_MALLOC_LIMIT=1000000000
# export RUBY_FREE_MIN=500000
# export RUBY_HEAP_MIN_SLOTS=40000

def main
  # GC::Profiler.enable
  # limit = 10 ** 6
  limit = 5 * (10 ** 7)
  prime_limit = (limit * Math.sqrt(2)).to_i
  prime_cache = Prime::Cache.new(prime_limit)
  primes = prime_cache.primes.select {|prime| prime % 8 == 1 || prime % 8 == 7}
  prime_cache = nil
  prime_length = primes.length
  puts "Primes cached. Length: #{prime_length}"

  # GC.disable
  sqrts = []
  tick = Time.new
  primes.each_with_index do |prime, prime_index|
    if prime_index % (10 ** 4) == 0
      tock = Time.new
      puts "#{prime_index}/#{prime_length}\t#{tock - tick}"
      tick = tock
    end
    sqrts << modular_sqrt((prime + 1)/2, prime)
  end
  puts "Square roots cached"
  # GC.enable

  is_prime_per_n = [true] * (limit + 1)
  [0, 1].each do |exception_index|
    is_prime_per_n[exception_index] = false
  end

  primes.each_with_index do |prime, prime_index|
    puts "#{prime_index}/#{prime_length}" if prime_index % (10 ** 5) == 0
    sqrt1 = sqrts[prime_index]

    [sqrt1, prime - sqrt1].each do |sqrt|
      raise "#{prime}'s sqrt is 0" if sqrt == 0
      if sqrt == 1
        sqrt += prime
      end
      
      if sqrt <= limit && (2 * sqrt * sqrt - 1 != prime)
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
  # puts GC::Profiler.result
end

puts Benchmark.measure { main }
