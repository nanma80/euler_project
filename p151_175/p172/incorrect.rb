# Incorrect
# misread the question as "no digit occurs more than three times IN A ROW"

def brute_force(digit_count, max_repeat_length)
  count = 0

  forbidden_strings = []
  (0..9).each do |digit|
    forbidden_strings << (digit.to_s * (max_repeat_length + 1))
  end

  (10 ** (digit_count - 1)..(10 ** digit_count - 1)).each do |n|
    n_string = n.to_s
    valid = true
    forbidden_strings.each do |forbidden_string|
      if n_string.include?(forbidden_string)
        valid = false
        break
      end
    end

    if valid
      count += 1
    end
  end
  count
end

def count(digit_count, max_repeat_length)
  count = {}
  (1..9).each do |leading_digit|
    count[ [leading_digit, 1] ] = 1
  end

  (2..digit_count).each do |digit_position|
    new_count = Hash.new { |hash, key| hash[key] = 0 }
    count.each do |ending_array, count_per_ending|
      last_digit = ending_array.first
      repeat_count = ending_array.last

      (0..9).each do |new_digit|
        if new_digit != last_digit
          new_count[ [ new_digit, 1] ] += count_per_ending
        elsif repeat_count < max_repeat_length
          new_count[ [ last_digit, repeat_count + 1] ] += count_per_ending
        end
      end
    end
    count = new_count
  end
  count.values.inject(:+)
end

digit_count = 5
max_repeat_length = 3
p brute_force(digit_count, max_repeat_length)
p count(digit_count, max_repeat_length)