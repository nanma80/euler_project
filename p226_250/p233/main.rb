require '../../common'

def each_seed(limit, special_primes)
  special_primes.permutation(3) do |perm|
    seed = (perm[0] ** 3) * (perm[1] ** 2) * perm[2]
    if seed <= limit
      yield seed
    end
  end
end

def expand_seed(limit, seed, other_primes)
  if seed > limit
    return
  end

  if other_primes.empty?
    return yield seed
  end

  prime = other_primes[0]
  rest = other_primes[1..-1]

  current = seed
  while current <= limit
    expand_seed(limit, current, rest) do |number|
      yield number
    end
    current *= prime
  end
end

def main
  limit = 3 * 10 ** 6
  prime_limit = limit / (5 ** 3) / (13 ** 2)

  primes = Prime::Cache.new(prime_limit).primes
  puts "Total number of primes: #{primes.length}"

  special_primes = primes.select do |prime|
    prime % 4 == 1
  end
  puts "Number of special primes: #{special_primes.length}"

  other_primes = primes.select do |prime|
    prime % 4 != 1
  end
  puts "Number of other primes: #{other_primes.length}"

  sum = 0
  count = 0
  # values = []
  each_seed(limit, special_primes) do |seed|
    expand_seed(limit, seed, other_primes) do |n|
      # values << n
      count += 1
      sum += n
    end
  end
  puts "Number of values: #{count}"
  puts "Sum of values: #{sum}"
end

main

