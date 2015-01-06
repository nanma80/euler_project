require '../../common'

def is_prime(n, primes)
  return false if n < 2
  primes.each do |prime|
    break if prime * prime > n
    return false if n % prime == 0
  end
  true
end

def positions(count, min, max)
  if count == 0
    yield []
    return
  end

  if min > max
    return
  end

  (min..max).each do |first_position|
    positions(count - 1, first_position + 1, max) do |sub_position|
      yield [first_position] + sub_position
    end
  end
end

def other_digits(count, digit_to_avoid)
  if count == 0
    yield []
    return
  end

  (0..9).each do |digit|
    next if digit == digit_to_avoid
    other_digits(count - 1, digit_to_avoid) do |sub_digits|
      yield [digit] + sub_digits
    end
  end
end

def repeated_numbers(digit_count, other_digit_count, repeated_digit)
  template = [repeated_digit] * digit_count

  positions(other_digit_count, 0, digit_count - 1) do |position|
    other_digits(other_digit_count, repeated_digit) do |digits|
      output = template.dup
      position.each_with_index do |pos, i|
        output[pos] = digits[i]
      end
      next if output.first == 0
      yield output.map(&:to_s).join.to_i
    end
  end
end

def primes_with_repeated_digit(digit_count, repeated_digit, primes)
  (0..(digit_count-2)).each do |other_digit_count|
    found_primes = []
    found = false
    repeated_numbers(digit_count, other_digit_count, repeated_digit) do |n|
      if is_prime(n, primes)
        found = true
        found_primes << n
      end
    end
    if found
      return found_primes, (digit_count - other_digit_count)
    end
  end
  raise 'Cannot find any'
end

def sum(digit_count)
  primes = Prime::Cache.new(10 ** (digit_count / 2)).primes
  sum = 0
  (0..9).each do |repeated_digit|
    found, occurrence = primes_with_repeated_digit(digit_count, repeated_digit, primes)
    sum += found.inject(:+)
  end
  sum
end

digit_count = 10
p sum(digit_count)
