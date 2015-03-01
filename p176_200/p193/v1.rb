require '../../common'
require 'benchmark'

# doesn't work for 2 ** 50 because stack too deep
class Agent
  attr_reader :limit

  def initialize(limit)
    @limit = limit
    @cache_f = {}
    @primes = Prime::Cache.new(Math.sqrt(limit).to_i).primes
    puts "Cached #{@primes.length} prime numbers"
  end

  def f(prime_index, n)
    if n <= 3
      return n
    end

    if prime_index == -1
      return n
    end

    unless @cache_f[[prime_index, n]].nil?
      return @cache_f[[prime_index, n]]
    end


    prime = @primes[prime_index]
    result = f(prime_index - 1, n) - f(prime_index - 1, n / (prime ** 2))
    @cache_f[[prime_index, n]] = result
    result
  end

  def non_square_free
    f(@primes.length - 1, limit)
  end
end

def main
  limit = 2 ** 33
  agent = Agent.new(limit)
  puts agent.non_square_free
end

puts Benchmark.measure { main }
