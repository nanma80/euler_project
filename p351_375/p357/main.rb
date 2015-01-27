require '../../common'
require 'benchmark'

def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    puts pointer if (pointer % (10 ** 6) == 0) || pointer < 100
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

def main
  limit = 10 ** 8
  all_factors = all_factors(limit)
  sum = 1 # because 1 is good
  (1..limit/2 - 1).each do |half_n|
    n = 2 * half_n
    factors = all_factors[n]
    next if factors.inject(:*) != n

    next unless all_factors[n + 1].length <= 1
    
    is_good = true
    (1..factors.length/2).each do |factor_count|
      factors.combination(factor_count) do |comb|
        d = comb.inject(:*)
        dividor_sum = d + n/d
        if all_factors[ dividor_sum ].length > 1 || all_factors[dividor_sum].first != dividor_sum
          is_good = false
          break
        end
      end
      break unless is_good
    end
    next unless is_good
    sum += n
  end
  p sum
end

p Benchmark.measure { main }
