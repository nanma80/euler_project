require '../../common'

def sum_harshad_primes(limit_exponent)
  limit = 10 ** limit_exponent
  prime_limit = Math.sqrt(limit).to_i
  prime_cache = Prime::Cache.new(prime_limit)

  sum = 0

  current_generation = [(1..9).to_a, (1..9).to_a].transpose

  (2..limit_exponent - 1).each do
    next_generation = []
    current_generation.each do |array|
      current_number = array[0]
      current_sum = array[1]

      (0..9).each do |extra_digit|
        new_number = current_number * 10 + extra_digit
        new_sum = current_sum + extra_digit
        if new_number % new_sum == 0
          next_generation << [new_number, new_sum]
          if prime_cache.is_prime?(new_number / new_sum)
            # new_number is strong Harshad
            [1, 3, 7, 9].each do |prime_digit|
              potential_prime = new_number * 10 + prime_digit
              if prime_cache.is_prime?(potential_prime)
                sum += potential_prime
                # puts potential_prime
              end
            end
          end
        end
      end
    end
    current_generation = next_generation
    # p current_generation.length
  end
  sum
end

limit_exponent = 14
p sum_harshad_primes(limit_exponent)