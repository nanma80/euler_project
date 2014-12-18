sum = 0

(2 ** 1000).to_s.split('').each do |digit_string|
  sum += digit_string.to_i
end

p sum # 1366