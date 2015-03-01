require '../../common'
require 'benchmark'

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

  def each_subset(start_index = 0, product_limit = nil)
    product_limit ||= sqrt_limit
    if start_index >= @prime_count || @primes[start_index] > product_limit
      return
    end

    (start_index..@primes.length - 1).each do |index1|
      prime1 = @primes[index1]
      yield [prime1]
      each_subset(index1 + 1, product_limit / prime1) do |subset_suffix|
        yield [prime1] + subset_suffix
      end
    end
  end

  def each_product_sign
    each_subset do |subset|
      sign = (subset.length % 2 == 0) ? 1 : -1
      product = subset.inject(:*)
      yield product, sign
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
