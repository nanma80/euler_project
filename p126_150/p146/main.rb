require '../../common'
require 'benchmark'

def main
  limit = (10 ** 6) * 150
  prime_cache = Prime::Cache.new(limit)
  primes = prime_cache.primes[4..-1]
  puts "Caching completed"

  prime_additions = [1, 3, 7, 9, 13, 27]
  non_prime_additions = [11, 17, 19, 21, 23]
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

      all_prime = true
      primes.each do |prime|
        break if prime > n + 5
        remainder = ((n % prime) ** 2) % prime
        prime_additions.each do |addition|
          if (remainder + addition) % prime == 0
            all_prime = false # if divisible by any prime, the number is not a prime, abort
            break
          end
        end
        break unless all_prime
      end

      next unless all_prime

      n_sq = n * n
      all_non_prime = true
      non_prime_additions.each do |addition|
        to_check = n_sq + addition
        is_prime = prime_cache.is_prime?(to_check)
        if is_prime
          all_non_prime = false
          break
        end
      end

      next unless all_non_prime

      puts "Found good n: #{n}"
      sum += n
    end

    break if should_break  
  end

  puts "Sum of good n's: #{sum}"
end

puts Benchmark.measure { main }