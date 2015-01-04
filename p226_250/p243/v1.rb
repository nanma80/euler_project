require '../../common'

def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    puts pointer if (pointer % (10 ** 5) == 0)
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
  target_ratio = 1.0 * 15499 / 94744
  puts "target ratio: #{target_ratio}"

  limit = 4 * (10 ** 7)
  all_factors(limit).each_with_index do |factors, n|
    next if n < 2
    puts n if (n % (10 ** 4) == 0)
    phi = phi(n, factors)
    ratio = 1.0 *  phi/ (n - 1)
    p [phi, n, ratio] if n == 9699690 || n == 510510
    if ratio < target_ratio
      puts n
      break
    end
  end
end

main

# By intuition
# puts 2 * 3 * 5 * 7 * 11 * 13 * 17 # 510510
