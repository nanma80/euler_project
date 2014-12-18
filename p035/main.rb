LIMIT = 1_000_000
# LIMIT = 1000

def primes(limit)
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

def rotations(number)
  output = [number]
  while output.length < number.to_s.length
    number_string = output.last.to_s
    new_number = (number_string[-1] + number_string[0..-2]).to_i
    output << new_number
  end
  output
end

def is_circular_prime(number, primes)
  rotations(number).each do |rotation|
    if not primes[rotation]
      return false
    end
  end
  true
end

primes_list = primes(LIMIT)
count = 0

(1..(LIMIT - 1)).each do |number|
  if is_circular_prime(number, primes_list)
    p number
    count += 1
  end
end

p count # 55
