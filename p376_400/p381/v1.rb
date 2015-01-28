require '../../common'

def sum_modular_factorial(prime)
  sum = 0
  (1..5).each do |diff|
    n = prime - diff
    mod_fact = 1
    (1..n).each do |k|
      mod_fact = (mod_fact * k) % prime
    end
    # p [prime, mod_fact] if diff == 5
    sum = (sum + mod_fact) % prime
  end
  sum
end

limit = 10 ** 4
primes = Prime::Cache.new(limit).primes
sum = 0
primes.each do |prime|
  next if prime < 5
  sum += sum_modular_factorial(prime)
end

p sum