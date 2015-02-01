def main
  digit_count = 20

  counts = Hash.new { |hash, key| hash[key] = 0 }
  (1..9).each do |d1|
    (0..9).each do |d2|
      next if d1 + d2 > 9
      counts[[d1, d2]] += 1
    end
  end

  (digit_count - 2).times do
    new_counts = Hash.new { |hash, key| hash[key] = 0 }
    counts.each do |last_two_digits, count|
      max_allowed = 9 - last_two_digits.inject(:+)
      (0..max_allowed).each do |d3|
        new_counts[[last_two_digits[1], d3]] += count
      end
    end
    counts = new_counts
  end
  p counts.values.inject(:+)
end

main