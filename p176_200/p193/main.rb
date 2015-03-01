require '../../common'
require 'benchmark'

# Based on v2. But instead of iterate over subsets, iterate over products only

class Agent
  attr_reader :limit, :sqrt_limit, :prime_count

  def initialize(limit)
    @limit = limit
    @cache_f = {}
    @sqrt_limit = Math.sqrt(limit).to_i
    @primes = Prime::Cache.new(@sqrt_limit).primes
    @prime_count = @primes.length
    puts "Cached #{@prime_count} prime numbers"
  end

  def each_product_sign(start_index = 0, product_limit = nil)
    product_limit ||= sqrt_limit

    (start_index..@primes.length - 1).each do |index1|
      prime1 = @primes[index1]
      return if prime1 > product_limit

      yield prime1, -1

      each_product_sign(index1 + 1, product_limit / prime1) do |product_suffix, sign_suffix|
        yield prime1 * product_suffix, - sign_suffix
      end
    end
  end

  def non_square_free
    count = limit
    each_product_sign do |product, sign|
      count += sign * (limit / (product * product))
    end
    count
  end
end

def main
  limit = 2 ** 30
  agent = Agent.new(limit)
  puts agent.non_square_free
end

puts Benchmark.measure { main }
