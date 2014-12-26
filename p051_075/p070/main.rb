def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    puts pointer if pointer % (10**5) == 0
    next unless all_factors[pointer].empty?
    all_factors[pointer] = all_factors[pointer] + [pointer]
    set_pointer = pointer + pointer
    while set_pointer <= limit
      all_factors[set_pointer] = all_factors[set_pointer] + [pointer]
      set_pointer += pointer
    end
  end
  puts "Cached all factors for all integers under #{limit}"
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
  min_ratio = nil
  min_ratio_n = 0

  limit = 10 ** 7
  all_factors(limit).each_with_index do |factors, n|
    next if n < 2
    phi = phi(n, factors)
    next unless n.to_s.split('').sort == phi.to_s.split('').sort
    p [n, phi]
    ratio = 1.0 * n / phi
    if min_ratio.nil? || ratio < min_ratio
      min_ratio = ratio
      min_ratio_n = n
    end
  end
  puts min_ratio_n
end

main
# 8319823