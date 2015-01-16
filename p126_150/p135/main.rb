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
      break if n == 1
    end
    factors.transpose
  end

  def each_divisor(primes)
    factors = factors(primes)
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

limit = 10 ** 6
primes = Prime::Cache.new(limit).primes

count_ten_solutions = 0
(3..limit).each do |n|
  count = 0
  n.each_divisor(primes) do |divisor|
    other_divisor = n / divisor
    next if (divisor + other_divisor) % 4 != 0
    d = (divisor + other_divisor) / 4
    next if divisor <= d
    count += 1
  end

  if count == 10
    p n
    count_ten_solutions += 1
  end
end

p count_ten_solutions