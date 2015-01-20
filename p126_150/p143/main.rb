require 'set'
require 'benchmark'

def main
  # limit = 12000
  limit = 1200

  squares = Set.new
  (1..limit).each do |n|
    squares << n * n
  end
  puts "Squares cached"

  pairs = Hash.new { |hash, key| hash[key] = [] }
  (1..limit/2).each do |n1|
    print "#{2000 * n1 / limit}/1000\r" if n1 % 100 == 0
    (n1..limit-n1).each do |n2|
      sq = n1 * n1 + n1 * n2 + n2 * n2
      if squares.include?(sq)
        pairs[n1] << n2
        p [n1, n2]
      end
    end
  end
  puts "#{pairs.length} Pairs cached"

  sums = []
  puts "Limit of p: #{limit / 3}"
  (1..limit/3).each do |p|
    pairs[p].each do |q|
      r_candidates = Set.new(pairs[q])
      pairs[p].each do |r|
        next unless q <= r
        next unless r_candidates.include?(r)
        next unless p + q + r <= limit

        puts "#{p}, #{q}, #{r}"
        sums << p + q + r
      end
    end
  end

  puts "Before dedup: #{sums.length}"
  sums = sums.uniq
  puts "After dedup: #{sums.length}"
  p sums.inject(:+)
end

p Benchmark.measure { main }
