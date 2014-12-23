require '../../common'

limit = 10 ** 6
prime_cache = Prime::Cache.new(limit)
primes = prime_cache.primes

index_limit = primes.length - 1

max_count = 0
max_count_sum = 0

(0..index_limit).each do |start_index|
  sum = primes[start_index]
  
  (1..(index_limit - start_index)).each do |count|
    sum += primes[start_index + count]
    break if sum > limit
    if prime_cache.is_prime?(sum)
      if count > max_count
        max_count = count + 1
        max_count_sum = sum
      end
    end
  end
end

p [max_count, max_count_sum]