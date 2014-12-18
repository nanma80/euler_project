# LIMIT = 1_000_000
LIMIT = 1000000

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

def truncates(number)
  output = [number]
  number_string = number.to_s
  (1..(number_string.length - 1)).each do |trucate_length|
    output << number_string[trucate_length..-1].to_i
    output << number_string[0..(-1 - trucate_length)].to_i
  end
  output
end

def is_truncatable_prime(number, all_primes)
  truncates(number).each do |to_test|
    if not all_primes[to_test]
      return false
    end
  end
  true
end

all_primes = primes(LIMIT)
count = 0
sum = 0

(10..(LIMIT-1)).each do |number|
  if is_truncatable_prime(number, all_primes)
    count += 1
    p number
    sum += number
  end
end

p count
p sum

