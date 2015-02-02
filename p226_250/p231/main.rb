require 'set'

def all_factors(limit)
  all_factors = []
  (limit + 1).times { all_factors << [] }

  (2..limit).each do |pointer|
    puts pointer if pointer < 100 || pointer % (10 ** 5) == 0
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

def sum_of_factors(n, factors)
  sum = 0
  factors.each do |factor|
    while n % factor == 0
      sum += factor
      n /= factor
    end
  end
  sum
end

million = 10 ** 6
n = 20 * million
k = 5 * million

denominator_sum = 0
numerator_sum = 0

all_factors = all_factors(n)
puts "Factors cached"
(1..n).each do |number|
  if number <= k
    denominator_sum += sum_of_factors(number, all_factors[number])
  end

  if number > (n - k)
    numerator_sum += sum_of_factors(number, all_factors[number])
  end
end

p numerator_sum - denominator_sum