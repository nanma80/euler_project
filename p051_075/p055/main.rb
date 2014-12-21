def is_lynchrel?(number)
  50.times do
    new_number = number + number.to_s.reverse.to_i
    return false if new_number.to_s == new_number.to_s.reverse
    number = new_number
  end
  true
end

count = 0
limit = 10 ** 4

(1..limit).each do |n|
  count += 1 if is_lynchrel?(n)
end

p count
