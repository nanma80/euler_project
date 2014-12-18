limit = 100

sum = 0
sum_squares = 0

for i in 1..limit
  sum += i
  sum_squares += i * i
end

diff = sum * sum - sum_squares

puts diff # 25164150