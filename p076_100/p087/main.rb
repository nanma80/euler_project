require '../../common'
require 'set'

limit = 50
limit = 50_000_000

prime_limit = Math.sqrt(limit)

primes = Prime::Cache.new(prime_limit).primes
powers = []
(2..4).each do |exp|
  powers << primes.map { |prime| prime ** exp }
end

good_numbers = Set.new

powers[0].each do |p2|
  powers[1].each do |p3|
    break if p3 > limit
    powers[2].each do |p4|
      break if p4 > limit
      sum = p2 + p3 + p4
      if sum < limit
        good_numbers << sum
      end
    end
  end
end

p good_numbers.length