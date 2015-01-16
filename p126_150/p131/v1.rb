require '../../common'

def has_partner(prime)
  (1..prime*10).each do |n|
    maybe_cube = n ** 3 + (n ** 2) * prime
    # p maybe_cube
    if (maybe_cube ** (1.0 / 3) + 0.5).to_i ** 3 == maybe_cube
      p [prime, n]
      return true
    end
  end
  false
end

# p has_partner(271)

def main
  prime_limit = 10 ** 3
  primes = Prime::Cache.new(prime_limit).primes

  count = 0
  primes.each do |prime|
    # puts prime if prime > 10 ** 5
    if has_partner(prime)
      count += 1
    end
  end

  p count
end

main
