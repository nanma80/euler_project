LIMIT = 10000

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

def primes(is_prime)
  primes = []
  is_prime.each_with_index do |check, index|
    primes << index if check
  end
  primes
end

def odd_composite_numbers(is_prime)
  (1..(LIMIT/2-1)).each do |n|
    odd_number = 2 * n + 1
    yield odd_number unless is_prime[odd_number]
  end
end

prime_check = is_prime(LIMIT)
prime_list = primes(prime_check)
# p primes(prime_check)

def conjecture_holds(n, primes)
  primes.each do |prime|
    return false if prime > n
    root = Math.sqrt((n - prime) / 2)
    return true if root.to_i == root
  end
end

odd_composite_numbers(prime_check) do |odd|
  if conjecture_holds(odd, prime_list)
    # puts odd
  else
    puts odd
    exit
  end
end

