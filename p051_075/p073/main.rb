require 'set'

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

def proper_fractions_in_range(den, all_factors)
  return 0 if den < 2
  count = 0
  min_num = den / 3
  max_num = den / 2
  factors_den = Set.new(all_factors[den])
  (min_num..max_num).each do |num|
    if 3 * num > den && 2 * num < den
      factors_num = Set.new(all_factors[num])
      if (factors_den & factors_num).empty?
        count += 1
      end
    end
  end
  count
end

def main
  limit = 12_000
  # limit = 8000

  count = 0
  all_factors = all_factors(limit)

  (2..limit).each do |den|
    puts den if den % 100 == 0
    count += proper_fractions_in_range(den, all_factors)
  end
  p count
end

main

# 7295372