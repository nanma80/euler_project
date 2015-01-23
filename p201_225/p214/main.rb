require '../../common'

def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    puts pointer if pointer % (10**5) == 0 || pointer < 100
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

limit = 4 * (10 ** 7)
target_length = 25
cache = {
  1 => 1
}

sum = 0
all_factors = all_factors(limit)
all_factors.each_with_index do |factors, n|
  start_value = n
  is_prime = (n == factors.first)
  if is_prime
    path = []
    while cache[n].nil?
      path << n
      n = phi(n, all_factors[n])
    end
    length = cache[n]

    path.reverse.each do |number_in_path|
      length += 1
      cache[number_in_path] = length
    end

    if length == target_length
      sum += start_value
      p start_value
    end
  end
end

p sum
