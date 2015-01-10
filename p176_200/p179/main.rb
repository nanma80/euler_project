def all_factors(limit)
  all_factors = []
  current_numbers = []

  (limit+1).times do |i|
    all_factors << {}
    current_numbers << i
  end

  (2..limit).each do |n|
    puts n if n % (10 ** 5) == 0 || n < 500
    next if current_numbers[n] == 1
    factor = current_numbers[n]
    k = n

    while k <= limit
      current_numbers[k] /= factor
      all_factors[k][factor] = (all_factors[k][factor]||0) + 1
      k += n
    end
  end
  all_factors
end

def divisor_count(factor_hash)
  count = 1
  factor_hash.values.each do |exp|
    count *= exp + 1
  end
  count
end

limit = 10 ** 7
all_factors = all_factors(limit)
puts "Cached all factors"

last_count = divisor_count(all_factors[2])
consecutive_count = 0

(3..limit).each do |n_plus_one|
  puts n_plus_one if n_plus_one % (10 ** 5) == 0
  count = divisor_count(all_factors[n_plus_one])
  if last_count == count
    consecutive_count += 1
  end
  last_count = count
end

puts
p consecutive_count
