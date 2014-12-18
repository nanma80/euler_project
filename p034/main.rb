factorials = [1]
(1..9).each do |k|
  factorials << factorials.last * k
end

limit = factorials.last * 10
limit = 100_000

sum_of_good_numbers = 0

(10..limit).each do |number|
  digits = number.to_s.split('').map(&:to_i)
  sum = 0
  digits.each do |digit|
    sum += factorials[digit]
  end
  if sum == number
    # p number
    sum_of_good_numbers += number
  end
end

p sum_of_good_numbers