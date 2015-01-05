# non_decreasing_count(digit_count, last_digit)
# = sum{i = 1 .. last_digit} non_decreasing_count(digit_count - 1, i)
# Boundry condition: non_decreasing_count(1, i) = 1 for all i = 1..9

limit = 100
non_decreasing_count = [[0] * 10, [0] + [1] * 9]
total_non_bouncy_count = 9

(2..limit).each do |digit_count|
  sum = 0
  row = []
  (0..9).each do |last_digit|
    sum += non_decreasing_count.last[last_digit]
    row << sum
    total_non_bouncy_count += sum
  end
  non_decreasing_count << row
end

# p non_decreasing_count

# non_increasing_count(digit_count, last_digit)
# = sum{i = last_digit..9} non_increasing_count(digit_count - 1, i)
# Boundry condition: non_increasing_count(1, i) = 1 for all i =1..9

non_increasing_count = [[0] * 10, [0] + [1] * 9]
total_non_bouncy_count += 9

(2..limit).each do |digit_count|
  sum = 0
  row = []
  (0..9).to_a.reverse.each do |last_digit|
    sum += non_increasing_count.last[last_digit]
    row << sum
    total_non_bouncy_count += sum
  end
  non_increasing_count << row.reverse
end

# p non_increasing_count

total_non_bouncy_count -= 9 * limit # for because pure digit numbers are double counted

p total_non_bouncy_count

# total = non_increasing_count