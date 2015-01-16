require '../../common'

def main
  limit = 5 * (10 ** 7)
  primes = Prime::Cache.new(limit).primes
  puts "Cache ready"

  count = 0
  primes.each do |prime|
    if prime % 4 == 3
      count += 1
    end
  end

  count += 2 # for 4 and 16
  primes.each do |prime|
    next if prime == 2
    break if prime * 4 >= limit
    count += 1
  end

  primes.each do |prime|
    next if prime == 2
    break if prime * 16 >= limit
    count += 1
  end

  p count
end

main