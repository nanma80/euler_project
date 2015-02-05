require '../../common'

def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    # puts pointer if (pointer % (10 ** 5) == 0)
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

def factor_exp(n, factors)
  factors.each do |factor|
    exponent = 0
    while n % factor == 0
      exponent += 1
      n /= factor
    end
    yield factor, exponent
  end
end


limit = 64 * (10 ** 6)

all_factors = all_factors(limit)
puts "factors cached"
total = 0

(1..limit - 1).each do |n|
  sum = 1
  factor_exp(n, all_factors[n]) do |factor, exponent|
    sum *= (factor ** (2 * (exponent + 1)) - 1)/(factor * factor - 1)
  end
  # p [n, sum]

  sum_sqrt = (Math.sqrt(sum) + 0.5 - 0.1 ** (10)).to_i
  if sum_sqrt * sum_sqrt == sum
    total += n
  end
end

p total
