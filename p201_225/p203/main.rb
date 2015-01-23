require '../../common'
require 'set'

def is_square_free(n, primes)
  primes.each do |prime|
    break if prime * prime > n
    next if n % prime != 0
    n /= prime
    if n % prime == 0
      return false
    end
  end
  true
end

limit = 51
prime_limit = 10 ** 2
primes = Prime::Cache.new(prime_limit).primes
square_free_numbers = Set.new

limit.times do |n|
  (0..n/2).each do |k|
    binomial = n.choose(k)
    if is_square_free(binomial, primes)
      square_free_numbers << binomial
    end
  end
end

p square_free_numbers
puts "Lemgth:"
p square_free_numbers.length
puts "Sum:"
p square_free_numbers.inject(:+)
