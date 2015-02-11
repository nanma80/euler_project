require '../../common'
require 'pp'

def each_reducable(prime, limit)
  bases = (1..limit/prime).to_a.map {|n| prime * n}
  generator_limit = 2 ** (bases.length)
  generator_limit.times do |gen|
    next if gen == 0
    selected = (gen + generator_limit).to_s(2)[1..-1].split('').map {|c| c == '1'}
    selected_bases = [bases, selected].transpose.select {|arr| arr[1]}.map {|arr| arr[0]}

    sum = Rational(0)
    selected_bases.each do |base|
      sum = sum + Rational(1, base ** 2)
    end
    next if sum.denominator % prime == 0
    yield [sum, selected_bases]
  end
end

def blocks(limit)
  primes = Prime::Cache.new(limit).primes
  blocks = []
  primes[2..-1].each do |prime|
    each_reducable(prime, limit) do |reducable|
      blocks << reducable
      p reducable
    end
  end

  blocks
end

limit = 35
blocks = blocks(limit)
blocks.each do |reducable|
  p [reducable.first, reducable.first.to_f, reducable.last]
end

# reducables(7, 45)