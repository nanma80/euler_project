require '../../common'

def sum_modular_factorial(prime)
  minus_3 = (prime - 1)/2
  minus_4 = (minus_3 * (prime - 3).mod_pow(prime - 2, prime)) % prime
  minus_5 = (minus_4 * (prime - 4).mod_pow(prime - 2, prime)) % prime

  sum = [minus_3, minus_4, minus_5].inject(:+) % prime
  sum
end

limit = 10 ** 8
primes = Prime::Cache.new(limit).primes
prime_count = primes.length
puts "cached #{prime_count} primes"
sum = 0
count = 0
primes.each do |prime|
  next if prime < 5
  puts "#{count}/#{prime_count}" if count % 1000 == 0
  sum += sum_modular_factorial(prime)
  count += 1
end

p sum