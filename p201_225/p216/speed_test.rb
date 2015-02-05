require './special_modular_sqrt'
require 'benchmark'
require 'set'

def main
  GC::Profiler.enable

  limit = 10 ** 5
  # limit = 5 * (10 ** 7)
  prime_limit = (limit * Math.sqrt(2)).to_i
  prime_cache = Prime::Cache.new(prime_limit)
  primes = prime_cache.primes.select {|prime| prime % 8 == 1 || prime % 8 == 7}
  prime_length = primes.length
  puts "Primes cached. Length: #{prime_length}"

  start_time = Time.new
  useless = [true] * (10 ** 7)
  useless = nil
  p Time.new - start_time

  GC.disable
  primes.each_with_index do |prime, prime_index|
    sqrt1 = modular_sqrt((prime + 1)/2, prime)
  end
  GC.enable

  puts GC::Profiler.result
end

puts Benchmark.measure { main }
