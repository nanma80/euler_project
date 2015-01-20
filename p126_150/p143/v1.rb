require 'set'
require 'benchmark'

def main
  limit = 12000
  # limit = 120000

  squares = Set.new
  (1..limit).each do |n|
    squares << n * n
  end

  sums = []
  puts "Limit of p: #{limit / 3}"
  (1..limit/3).each do |p|
    # print "#{p}\r"
    (p..(limit - p)/2).each do |q|
      b_sq = p * p + q * q + p * q
      unless squares.include? b_sq
        next
      end
      (q..(limit - p - q)).each do |r|
        a_sq = q * q + r * r + q * r
        unless squares.include?(a_sq)
          next
        end
        c_sq = p * p + r * r + p * r
        unless squares.include? c_sq
          next
        end

        a = (Math.sqrt(a_sq) + 0.5).to_i
        b = (Math.sqrt(b_sq) + 0.5).to_i
        c = (Math.sqrt(c_sq) + 0.5).to_i

        puts "#{p}, #{q}, #{r}, #{a}, #{b}, #{c}"
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
