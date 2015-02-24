def brute_force(digit_count, max_repeat_length)
  count = 0

  forbidden_strings = []
  (0..9).each do |digit|
    forbidden_strings << (digit.to_s * (max_repeat_length + 1))
  end

  (10 ** (digit_count - 1)..(10 ** digit_count - 1)).each do |n|
    n_string = n.to_s.split('').sort.join
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
  counts_per_histogram = {}
  empty = [0] * 10
  (1..9).each do |leading_digit|
    hist = empty.dup
    hist[leading_digit] += 1
    counts_per_histogram[hist] = 1
  end

  (2..digit_count).each do |digit_position|
    # puts digit_position
    new_counts = Hash.new { |hash, key| hash[key] = 0 }
    counts_per_histogram.each do |old_hist, count_per_hist|
      (0..9).each do |new_digit|
        next if old_hist[new_digit] == max_repeat_length
        new_hist = old_hist.dup
        new_hist[new_digit] += 1
        new_counts[new_hist] += count_per_hist
      end
    end
    counts_per_histogram = new_counts
  end

  counts_per_histogram.values.inject(:+)
end

digit_count = 18
max_repeat_length = 3
# p brute_force(digit_count, max_repeat_length)
p count(digit_count, max_repeat_length)
