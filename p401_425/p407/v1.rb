require 'benchmark'

def m(n)
  a = n - 1
  while a >= 0
    if a * (a - 1) % n == 0
      return a
    end
    a -= 1
  end
  raise "#{n}"
end

def main
  limit = 10 ** 2
  total = 0
  (1..limit).each do |n|
    m = m(n)
    total += m
    p [n, m] if m != 1
  end
  p total
end

puts Benchmark.measure { main }