LIMIT = 150000

def is_prime(limit)
  is_prime = [true] * limit
  is_prime[0] = false
  is_prime[1] = false
  (2..(limit-1)).each do |pointer|
    next unless is_prime[pointer]
    set_pointer = pointer + pointer
    while set_pointer < limit
      is_prime[set_pointer] = false
      set_pointer += pointer
    end
  end
  is_prime
end

def primes(limit)
  primes = []
  is_prime(limit).each_with_index do |check, index|
    primes << index if check
  end
  primes
end

def distinct_prime_factors(n, primes)
  distinct_factors = []
  primes.each do |prime|
    while n % prime == 0
      if distinct_factors.last != prime
        distinct_factors << prime
      end
      n = n / prime
      return distinct_factors if n == 1
    end
  end
end

def distinct_prime_factor_count(n, primes)
  distinct_prime_factors(n, primes).length
end

prime_list = primes(LIMIT)
# p distinct_prime_factors(9, prime_list)
puts "Prime list constructed. Number of primes under #{LIMIT}: #{prime_list.length}"

consecutive_count = 4
factor_count = consecutive_count
current_count = 0

(2..LIMIT).each do |n|
  if distinct_prime_factor_count(n, prime_list) == factor_count
    current_count += 1
    if current_count == consecutive_count
      puts 'Found'
      puts (n - consecutive_count + 1)
      exit
    end
  else
    current_count = 0
  end
end

# 134043