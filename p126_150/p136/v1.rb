require '../../common'
require 'benchmark'

class Integer
  def factors(prime_cache)
    n = self
    factors = []
    prime_cache.primes.each do |factor|
      next unless n % factor == 0
      exponent = 0
      while n % factor == 0
        n = n / factor
        exponent += 1
      end
      factors << [factor, exponent] unless exponent == 0

      if prime_cache.is_prime?(n)
        factors << [n, 1]
        break
      end

      if n == 1
        break
      end
    end
    factors.transpose
  end

  def each_divisor(prime_cache)
    factors = factors(prime_cache)
    primes = factors.first
    exponents = factors.last
    generator_limit = exponents.map {|n| n + 1}.inject(:*)
    generator_limit.times do |generator|
      divisor = 1
      exponents.each_with_index do |exponent, index|
        divisor *= primes[index] ** (generator % (exponent + 1))
        generator /= (exponent + 1)
      end
      yield divisor
    end
  end
end

def main
  limit = 1 * (10 ** 2)
  prime_cache = Prime::Cache.new(limit)
  puts "Cache ready"

  count_single_solution = 0
  (2..limit-1).each do |n|
    puts n if n % 10_000 == 0
    count = 0
    n.each_divisor(prime_cache) do |divisor|
      other_divisor = n / divisor
      next if (divisor + other_divisor) % 4 != 0
      d = (divisor + other_divisor) / 4
      next if divisor <= d
      count += 1
      break if count > 1
    end

    if count == 1
      count_single_solution += 1
    end
  end

  p count_single_solution
end

puts Benchmark.measure { main }