# http://oeis.org/A002407
# Prime hex numbers
# hex number: 3 * k * k + 3 * k + 1
# n = k ** 3
# m = k ** 3 + k ** 2

require '../../common'

def main
  prime_limit = 10 ** 6
  prime_cache = Prime::Cache.new(prime_limit)

  count = 0
  (1..Math.sqrt(prime_limit)).each do |n|
    candidate = 3 * n * n + 3 * n + 1
    break if candidate > prime_limit
    next unless prime_cache.is_prime?(candidate)
    count += 1
  end

  p count
end

main
