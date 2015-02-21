require 'set'
require 'benchmark'
require '../../common'

def m(p, q, n)
  if p * q > n
    return 0
  end

  max_so_far = 0
  (1..(Math.log(n / p, q) + 0.1 ** 10).to_i).each do |q_exp|
    p_exp = (Math.log(n / (q ** q_exp), p) + 0.1 ** 10).to_i
    current = (p ** p_exp) * (q ** q_exp)
    if current > max_so_far && current <= n
      max_so_far = current
    end
  end
  max_so_far
end

def main
  limit = 10 ** 2
  # limit = 10 ** 7
  prime_limit = limit / 2
  primes = Prime::Cache.new(prime_limit).primes
  puts "#{primes.length} primes cached"
  distinct_ms = Set.new
  primes.each_with_index do |prime1, prime1_index|
    puts prime1
    (prime1_index + 1..primes.length - 1).each do |prime2_index|
      prime2 = primes[prime2_index]
      break if prime1 * prime2 > limit
      # p [prime1, prime2]
      distinct_ms << m(prime1, prime2, limit)
    end
  end
  puts 'Sum:'
  p distinct_ms.inject(:+)
end

puts Benchmark.measure { main }

# incorrect:
# 11109693739272
