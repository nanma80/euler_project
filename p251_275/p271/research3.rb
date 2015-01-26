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

def x_values(n)
  exponent = 3
  output = []
  (2..n).each do |k|
    if (k ** exponent) % n == 1
      output << k
    end
  end
  output
end

factors = Prime::Cache.new(43).primes
all_factors = all_factors(10 ** 6)

7.times do |end_index|
  n_factors = (0..end_index).to_a.map {|index| factors[index] }
  n = n_factors.inject(:*)
  x_values = x_values(n)
  unless x_values.empty?
    x_values_with_phi = x_values.map do |x_value|
      [x_value, phi(x_value - 1, all_factors[x_value - 1])]
    end
    p [n, n_factors, x_values_with_phi]
  end
end
