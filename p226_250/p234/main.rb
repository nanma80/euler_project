require '../../common'

def semidivisibles_sum(limit)
  prime_limit = Math.sqrt(limit) + 100
  primes = Prime::Cache.new(prime_limit).primes

  semidivisibles_sum = 0

  (0..primes.length - 2).each do |index1|
    prime1 = primes[index1]
    break unless prime1 * prime1 < limit
    prime2 = primes[index1 + 1]

    multiplier1_min = prime1 + 1
    multiplier1_max = [prime2 * prime2, limit].min / prime1

    multiplier1_sum = (multiplier1_min + multiplier1_max) * 
      (multiplier1_max - multiplier1_min + 1) / 2

    if multiplier1_min <= prime2 && prime2 <= multiplier1_max
      multiplier1_sum -= prime2
    end

    semidivisibles_sum += prime1 * multiplier1_sum

    multiplier2_min = prime1 * prime1 / prime2 + 1
    multiplier2_max = [prime2 - 1, limit / prime2].min

    multiplier2_sum = (multiplier2_min + multiplier2_max) * 
      (multiplier2_max - multiplier2_min + 1) / 2

    if multiplier2_min <= prime1 && prime1 <= multiplier2_max
      multiplier2_sum -= prime1
    end

    semidivisibles_sum += prime2 * multiplier2_sum
  end

  semidivisibles_sum
end

# limit = 1000
limit = 999966663333
p semidivisibles_sum(limit)