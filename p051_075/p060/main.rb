require '../../common'

limit = 10 ** 3
prime_cache = Prime::Cache.new(limit)
primes = prime_cache.primes
puts "Cached #{primes.length} primes under #{limit}"

pairs = []

primes.each do |p1|
  primes.each do |p2|
    break if p2 > p1
    concat1 = (p1.to_s + p2.to_s).to_i
    concat2 = (p2.to_s + p1.to_s).to_i

    if prime_cache.is_prime?(concat1) && prime_cache.is_prime?(concat2)
      pairs << [p1, p2]
    end
  end
end

p pairs.length