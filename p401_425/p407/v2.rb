require 'benchmark'

def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    next unless all_factors[pointer].empty?
    all_factors[pointer] = all_factors[pointer] + [pointer]
    set_pointer = pointer + pointer
    while set_pointer <= limit
      all_factors[set_pointer] = all_factors[set_pointer] + [pointer]
      set_pointer += pointer
    end
  end
  all_factors
end

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
  limit = 10 ** 4
  total = 0
  all_factors = all_factors(limit)
  all_factors.each_with_index do |factors, n|
    next if n == 0
    if factors.length == 1
      total += 1
    else
      total += m(n)
    end
  end

  p total
end

puts Benchmark.measure { main }