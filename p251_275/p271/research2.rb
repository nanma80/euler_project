require '../../common'

factors = Prime::Cache.new(43).primes
p factors.inject(:*)
p factors.map {|prime| prime - 1}.inject(:*)