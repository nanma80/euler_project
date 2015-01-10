require '../../common'

class Integer
  def factors(primes)
    n = self
    factors = []
    primes.each do |factor|
      next unless n % factor == 0
      exponent = 0
      while n % factor == 0
        n = n / factor
        exponent += 1
      end
      factors << [factor, exponent] unless exponent == 0
    end

    factors.transpose
  end

  def divisor_count(primes)
    exponents = factors(primes).last
    count = 1

    exponents.each do |exponent|
      count *= (exponent + 1)
    end
    count
  end
end

limit = 10 ** 5
primes = Prime::Cache.new(limit).primes

last_count = 2.divisor_count(primes)
consecutive_count = 0

(3..limit).each do |n_plus_one|
  # puts n_plus_one if n_plus_one % (10 ** 4) == 0
  count = n_plus_one.divisor_count(primes)
  if last_count == count
    p n_plus_one
    consecutive_count += 1
  end
  last_count = count
end

puts
p consecutive_count
