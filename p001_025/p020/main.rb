product = 1

(1..100).each do |number|
  product *= number
end

sum = 0
product.to_s.split('').each do |digit|
  sum += digit.to_i
end

puts sum
