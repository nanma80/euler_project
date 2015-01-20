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

  def primary_b(prime_cache)
    return 1 if self == 1
    factors = factors(prime_cache)
    primes = factors[0]
    exponents = factors[1]
    b_exponents = exponents.map do |exponent|
      if exponent % 2 == 0
        exponent / 2
      else
        (exponent + 1) / 2
      end
    end
    [primes, b_exponents].transpose.map {|arr| arr[0] ** arr[1]}.inject(:*)
  end
end

def main
  limit = 10 ** 12
  a_limit = Math.sqrt(limit).to_i
  prime_cache = Prime::Cache.new(a_limit)
  
  sum = 0
  (1..a_limit).each do |a|
    primary_b = a.primary_b(prime_cache)
    b = 0
    while b ** 3 / a + a < limit
      b += primary_b
      next if b <= a
      n = b ** 3 / a + a
      if (Math.sqrt(n) + 0.5).to_i ** 2 == n && n < limit
        c = b ** 2 / a
        p [n, a, b, c]
        sum += n
      end
    end
  end

  puts "Sum: #{sum}"

end

main