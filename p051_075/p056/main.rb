def power_digit_sum(a, b)
  number = a ** b
  sum = 0
  number.to_s.split('').each do |c|
    sum += c.to_i
  end
  sum
end

max_sum = 0
max_case = []

(1..99).each do |a|
  (1..99).each do |b|
    sum = power_digit_sum(a, b)
    if sum > max_sum
      max_sum = sum
      max_case = [a, b, a ** b, sum]
    end
  end
end

p max_sum
p max_case