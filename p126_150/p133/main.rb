require '../../common'
require 'set'

def can_be_factor?(prime)
  visited = Set.new
  mod = prime * 9
  current_remainder = 10 % mod
  until visited.include?(current_remainder)
    if current_remainder == 0
      return false
    elsif current_remainder == 1
      return true
    end

    visited << current_remainder
    current_remainder = current_remainder.mod_pow(10, mod)
  end
  false
end

def main
  prime_limit = 10 ** 5
  primes = Prime::Cache.new(prime_limit).primes

  sum_non_factors = 0
  primes.each do |prime|
    p prime
    if !can_be_factor?(prime)
      sum_non_factors += prime
    end
  end

  p sum_non_factors
end

main
