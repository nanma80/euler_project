def divisor_of_right_rotation(n)
  string_n = n.to_s
  rotated_string = string_n[-1] + string_n[0..-2]
  rotated_n = rotated_string.to_i
  (rotated_n % n) == 0
end

upper_limit = 10 ** 6
lower_limit = 10
sum = 0
(lower_limit + 1..upper_limit - 1).each do |n|
  if divisor_of_right_rotation(n)
    sum += n
    p n
  end
end

puts "Sum of last 5 digits:"
p sum % (10 ** 5)