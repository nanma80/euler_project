require "bigdecimal"
require "bigdecimal/math"

sum = 0
(2..99).each do |n|
  next if Math.sqrt(n).to_i ** 2 == n
  sum += BigDecimal.new(n).sqrt(100).to_s[2..101].split('').map(&:to_i).inject(:+)
end
p sum