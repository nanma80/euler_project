require '../../common'

def each_seed(limit, special_primes)
  # 105 = 3 * 5 * 7
  special_primes.each_with_index do |prime1, index1|
    break if (prime1 ** 3) > limit
    special_primes.each_with_index do |prime2, index2|
      next if index2 == index1
      break if (prime1 ** 3) * (prime2 ** 2) > limit
      special_primes.each_with_index do |prime3, index3|
        next if index3 == index1 || index3 == index2
        seed = (prime1 ** 3) * (prime2 ** 2) * prime3
        break if seed > limit
        yield seed
      end
    end
  end

  # 105 = 15 * 7
  special_primes.each_with_index do |prime1, index1|
    break if (prime1 ** 7) > limit
    special_primes.each_with_index do |prime2, index2|
      next if index2 == index1
      break if (prime1 ** 7) * (prime2 ** 3) > limit
      seed = (prime1 ** 7) * (prime2 ** 3)
      yield seed
    end
  end

  # 105 = 21 * 5
  special_primes.each_with_index do |prime1, index1|
    break if (prime1 ** 10) > limit
    special_primes.each_with_index do |prime2, index2|
      next if index2 == index1
      break if (prime1 ** 10) * (prime2 ** 2) > limit
      seed = (prime1 ** 10) * (prime2 ** 2)
      yield seed
    end
  end
end

def numbers_without_factors(prime_limit, special_primes)
  output = []
  (prime_limit + 1).times do |n|
    output << n
  end

  special_primes.each do |prime|
    current = prime
    while current <= prime_limit
      output[current] = 0
      current += prime
    end
  end
  output
end

def partial_sum_without_factors(prime_limit, special_primes)
  numbers = numbers_without_factors(prime_limit, special_primes)
  sums = []
  counts = []
  sum = 0
  count = 0
  numbers.each do |number|
    if number != 0
      count += 1
    end
    sum += number
    sums << sum
    counts << count
  end
  return sums, counts
end

def main
  limit = (10 ** 11)
  # limit = 38000000
  # limit = 1 * (10 ** 6)
  prime_limit = limit / (5 ** 3) / (13 ** 2)
  puts "Limit: #{limit}"
  puts "Prime limit: #{prime_limit}"

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
  partial_sums, counts = partial_sum_without_factors(prime_limit, special_primes)

  sum = 0
  count = 0
  each_seed(limit, special_primes) do |seed|
    max_multiplier = limit / seed
    # p max_multiplier
    sum += partial_sums[max_multiplier] * seed
    count += counts[max_multiplier]
  end
  puts "Number of values: #{count}"
  puts "Sum of values: #{sum}"
end

main

