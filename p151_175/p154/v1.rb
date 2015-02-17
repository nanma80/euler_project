require 'benchmark'
require '../../common'

def brute_force_count(n, mod)
  count = 0
  total = 0
  (0..n).each do |i|
    (0..(n - i)).each do |j|
      k = n - i - j
      value = n.factorial / i.factorial / j.factorial / k.factorial
      if value % mod == 0
        count += 1
      end
      total += 1
    end
  end
  count
end

def symmetry_count(n, mod)
  count = 0
  (0..n).each do |i|
    (0..(n - i)).each do |j|
      break if j > i
      k = n - i - j
      next if k > j

      value = n.factorial / i.factorial / j.factorial / k.factorial
      next unless value % mod == 0
      if i == j && j == k
        count += 1
      elsif i == j || j == k
        count += 3
      else
        count += 6
      end
    end
  end
  count
end

def main
  # (0..5).each do |layer|
  #   p [layer, symmetry_count(layer, 10)]
  # end

  layer = 200
  p [layer, symmetry_count(layer, 10 ** 4)]
end

puts Benchmark.measure { main }
