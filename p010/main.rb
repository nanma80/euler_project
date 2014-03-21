def sum_of_primes_under(limit)
  is_prime = [true] * limit
  is_prime[0] = false
  is_prime[1] = false
  (2..(limit-1)).each do |pointer|
    next unless is_prime[pointer]
    set_pointer = pointer + pointer
    while set_pointer < limit
      is_prime[set_pointer] = false
      set_pointer += pointer
    end
  end
  return is_prime
end

def index_of_true(list)
  output = []
  list.each_with_index do |value, index|
    output << index if value
  end
  output
end

def sum(list)
  list.inject do |sum, x|
    sum + x
  end
end

limit = 2_000_000
p sum(index_of_true(sum_of_primes_under(limit)))
# 142913828922
