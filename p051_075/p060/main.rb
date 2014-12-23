require '../../common'
require 'set'

limit = 10 ** 4
level = 5
prime_cache = Prime::Cache.new(limit)
primes = prime_cache.primes
puts "Cached #{primes.length} primes under #{limit}"

def pairs(prime_cache)
  pairs_v1(prime_cache)
end

def pairs_v1(prime_cache)
  primes = prime_cache.primes
  pairs = Set.new
  primes.each do |p1|
    primes.each do |p2|
      break if p2 > p1
      concat1 = (p1.to_s + p2.to_s).to_i
      concat2 = (p2.to_s + p1.to_s).to_i

      if prime_cache.is_prime?(concat1) && prime_cache.is_prime?(concat2)
        pairs << [p2, p1]
      end
    end
  end
  pairs
end

def pairs_v2(prime_cache)
  primes = prime_cache.primes
  pairs = Set.new
  primes.each do |prime|
    prime_string = prime.to_s
    (1..(prime_string.length - 1)).each do |part1_length|
      part1 = prime_string[0..(part1_length - 1)]
      part2 = prime_string[part1_length..-1]
      next if part2.start_with?('0')
      next unless prime_cache.is_prime?(part1.to_i) && prime_cache.is_prime?(part2.to_i)
      next unless prime_cache.is_prime?((part2 + part1).to_i)
      pairs << [part1.to_i, part2.to_i].sort
    end
  end
  pairs
end

def clique(max_level, pairs)
  old_clique = pairs
  (3..max_level).each do |level|
    puts "Level #{level}"
    new_clique = Set.new
    clique_constructor = {}
    old_clique.each do |c|
      key = c[0..-2].map(&:to_s).join(',')
      if clique_constructor[key].nil?
        clique_constructor[key] = [c]
      else
        clique_constructor[key].each do |c0|
          if pairs.include?([c.last, c0.last].sort)
            new_clique << (c + [c0.last]).sort
          end
        end
        clique_constructor[key] << c
      end
    end
    old_clique = new_clique
    puts "Found #{old_clique.length} cliques in level #{level}"
  end
  old_clique
end

pairs = pairs_v1(prime_cache)
puts "Generated #{pairs.length} pairs"
cliques = clique(level, pairs)
p cliques

min_sum = nil
cliques.each do |clique|
  sum = clique.inject(0) {|s, e| s + e}
  if min_sum.nil? || sum < min_sum
    min_sum = sum
  end
end
puts "Min sum is"
p min_sum
