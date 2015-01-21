require 'benchmark'

def count_not_divisible(n, prime)
  n_string = n.to_s(prime)
  histogram = [0] * prime
  
  n_string.split('').each do |char|
    histogram[char.to_i] += 1
  end

  count = 1
  histogram.each_with_index do |occurrence, remainder|
    count *= (remainder + 1) ** occurrence
  end
  count
end


def main
  count = 0
  limit = 10 ** 3
  puts "limit #{limit} in base 7: #{limit.to_s(7)}"
  (0..limit - 1).each do |layer|
    count += count_not_divisible(layer, 7)
  end

  p count
end

p Benchmark.measure { main }

