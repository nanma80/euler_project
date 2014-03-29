require File.expand_path('../integer', __FILE__)

def is_sum_of_abundant_numbers?(n, abundant_numbers, is_abundant)
  abundant_numbers.each do |abundant_number|
    diff = n - abundant_number
    return true if diff > 0 && is_abundant[diff]
    return false if diff < abundant_number
  end
  false
end

MAX = 30_000

is_abundant = [false] * (MAX + 1)
abundant_numbers = []

(2..MAX).each do |n|
  if n.is_abundant?
    is_abundant[n] = true
    abundant_numbers << n
  end
end

not_sum_of_abundant_numbers = []

(1..MAX).each do |n|
  unless is_sum_of_abundant_numbers?(n, abundant_numbers, is_abundant)
    not_sum_of_abundant_numbers << n
  end
end

p not_sum_of_abundant_numbers.inject(:+)