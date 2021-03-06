require '../../common'

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

def phi(n, factors)
  output = n
  factors.each do |prime|
    output = output * (prime - 1)/prime
  end
  output
end

def main
  max_ratio = 0.0
  max_ratio_n = 0

  limit = 10 ** 6
  all_factors(limit).each_with_index do |factors, n|
    next if n < 2

    ratio = 1.0 * n / phi(n, factors)
    if ratio > max_ratio
      max_ratio = ratio
      max_ratio_n = n
    end
  end
  puts max_ratio_n
end

main

# By intuition
# puts 2 * 3 * 5 * 7 * 11 * 13 * 17 # 510510
