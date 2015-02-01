def count(digit_count, alphabet_size, including_zero)
  count = 1
  if including_zero
    count *= alphabet_size - 1
  else
    count *= alphabet_size
  end

  count *= alphabet_size ** (digit_count - 1)
  count
end

def main
  total = 0
  (1..16).each do |length|
    all_numbers = count(length, 16, true)
    no_zero = count(length, 15, false)
    no_one = count(length, 15, true)
    no_a = count(length, 15, true)
    no_zero_a = count(length, 14, false)
    no_zero_one = count(length, 14, false)
    no_a_one = count(length, 14, true)
    no_zero_one_a = count(length, 13, false)

    count_per_length = all_numbers - no_zero -
      no_a - no_one + no_a_one + no_zero_a +
      no_zero_one - no_zero_one_a
    total += count_per_length
  end
  puts total.to_s(16)
end

main