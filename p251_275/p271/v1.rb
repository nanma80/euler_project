require '../../common'
require 'set'
require 'benchmark'

def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    next unless all_factors[pointer].empty?
    all_factors[pointer] = all_factors[pointer] + [pointer]
    set_pointer = pointer + pointer
    while set_pointer <= limit
      all_factors[set_pointer] = all_factors[set_pointer] + [pointer]
      set_pointer += pointer
    end
  end
  all_factors
end

def phi(n, factors)
  output = n
  factors.each do |prime|
    output = output * (prime - 1)/prime
  end
  output
end

def x_values(n)
  exponent = 3
  output = []
  (2..n).each do |k|
    if (k ** exponent) % n == 1
      output << k
    end
  end
  output
end

def main
  limit = 1 * (10 ** 6)
  primes = Prime::Cache.new(limit).primes
  factor_count = 13

  factors = (0..factor_count).to_a.map {|index| primes[index] }
  # factors = [7, 13]
  n = factors.inject(:*)
  phi = factors.map {|prime| prime - 1}.inject(:*)
  # p factors
  puts "n: #{n}. phi: #{phi}"

  if phi % 3 != 0
    raise "n: #{n}, phi: #{phi} not divisible by 3"
  end

  numbers = Set.new
  (factor_count + 1..primes.length - 1).each do |prime_index|
    puts "#{prime_index}/#{primes.length}" if prime_index % 1000 == 1
    prime = primes[prime_index]
    exponent = phi / 3
    # p exponent
    while prime.mod_pow(exponent, n) == 1 && exponent % 3 == 0
      exponent /= 3
    end
    # p [exponent, prime.mod_pow(exponent, n)]
    numbers_per_loop = prime.mod_pow(exponent, n), prime.mod_pow(exponent * 2, n)
    # p [prime, numbers_per_loop]
    numbers_per_loop.each do |k|
      if k != 1
        numbers << k
      end
    end
  end
  puts "Found #{numbers.length} numbers"
  # puts numbers.to_a.sort
  puts "Sum: #{numbers.inject(:+)}"
end

p Benchmark.measure { main }
