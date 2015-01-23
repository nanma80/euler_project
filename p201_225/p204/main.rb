require '../../common'
require 'set'

def count(primes, limit)
  return 1 if primes.empty?
  prime = primes.first
  other_primes = primes[1..-1]

  count = 0
  power = 1
  while power <= limit
    count += count(other_primes, limit / power)
    power *= prime
  end
  count
end

limit = 10 ** 9
prime_limit = 100
primes = Prime::Cache.new(prime_limit).primes

p count(primes, limit)