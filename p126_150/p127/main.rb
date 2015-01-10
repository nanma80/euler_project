require 'set'

def all_factors(limit)
  all_factors = []
  (limit + 1).times { all_factors << [] }

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

def process_c(c, all_factors)
  sum = 0
  factors_c = all_factors[c]
  factors_c_count = factors_c.length

  (1..c/2).each do |a|
    b = c - a
    factors_a = all_factors[a]
    factors_b = all_factors[b]
    should_skip = false
    factors_a.each do |factor|
      if factors_c.include?(factor)
        should_skip = true
        break
      end
    end
    next if should_skip

    factors_b.each do |factor|
      if factors_c.include?(factor)
        should_skip = true
        break
      end
    end
    next if should_skip

    factors_a.each do |factor|
      if factors_b.include?(factor)
        should_skip = true
        break
      end
    end
    next if should_skip

    factors = (factors_c + factors_a + factors_b).uniq

    # new_factor_count = factors.length
    # next if factors_c_count + factors_a.length + factors_b.length != new_factor_count
    next unless factors.inject(:*) < c
    p [a, b, c]
    sum += c
  end
  sum
end

limit = 120000
all_factors = all_factors(limit)
total = 0
(2..limit - 1).each do |c|
  total += process_c(c, all_factors)
end
p total
