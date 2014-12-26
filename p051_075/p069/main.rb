require '../../common'

def factors(n, primes)
  factors = []
  primes.each do |prime|
    if n % prime == 0
      factors << prime
      while n % prime == 0
        n = n / prime
        return factors if n == 1
      end
    end
  end
  factors
end

def phi(n, primes)
  output = n
  factors(n, primes).each do |prime|
    output = output * (prime - 1)/prime
  end
  output
end

max_ratio = 0.0
max_ratio_n = 0
limit = 10 ** 6

primes = Prime::Cache.new(limit).primes

(1..limit).each do |n|
  puts n if n % 1000 == 0
  ratio = 1.0 * n / phi(n, primes)
  if ratio > max_ratio
    max_ratio = ratio
    max_ratio_n = n
  end
end

puts max_ratio_n
# By intuition
puts 2 * 3 * 5 * 7 * 11 * 13 * 17 # 510510
