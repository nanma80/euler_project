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

def process_a(a, limit, all_factors)
  sum = 0
  factors_a = all_factors[a]
  # factors_a_set = Set.new(factors_a)
  (a + 1..limit - a - 1).each do |b|
    should_skip = false
    all_factors[b].each do |factor_b|
      if factors_a.include?(factor_b)
        should_skip = true
        break
      end
    end
    next if should_skip

    c = a + b
    factors = factors_a + all_factors[b] + all_factors[c]
    next unless factors.inject(:*) < c
    p [a, b, c]

    sum += c
  end
  sum
end

start_time = Time.new
# limit = 10 ** 3
limit = 120000

all_factors = all_factors(limit)
total = 0
(1..limit-1).each do |a|
  total += process_a(a, limit, all_factors)
end
p total
puts "#{Time.new - start_time}"
