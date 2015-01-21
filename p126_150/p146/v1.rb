require '../../common'
require 'benchmark'

def main
  limit = (10 ** 5) * 1
  prime_cache = Prime::Cache.new(limit)
  puts "Caching completed"
  sum = 0
  multiplier_m = 210
  limit_m = limit / multiplier_m

  (0..limit_m).each do |m|
    print "#{m}/#{limit_m}\r" if m % 100 == 0
    should_break = false
    m_multiplied = m * multiplier_m
    [10, 80, 130, 200].each do |addition_m|
      n = m_multiplied + addition_m
      if n >= limit
        should_break = true
        break
      end

      n_sq = n * n
      conditions_satisfied = true

      [1, 3, 7, 9, 13, 27].each do |addition|
        to_check = n_sq + addition
        is_prime = prime_cache.is_prime?(to_check)
        if !is_prime
          conditions_satisfied = false
          break
        end
      end

      next unless conditions_satisfied

      [11, 17, 19, 21, 23].each do |addition|
        to_check = n_sq + addition
        is_prime = prime_cache.is_prime?(to_check)
        if is_prime
          conditions_satisfied = false
          break
        end
      end

      if conditions_satisfied
        puts "Found good n: #{n}"
        sum += n
      end
    end

    break if should_break  
  end

  puts "Sum of good n's: #{sum}"
end

puts Benchmark.measure { main }