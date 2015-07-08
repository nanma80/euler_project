def brute_force(limit)
  mod = 10 ** 9
  sum = 0

  (1..limit).each do |n|
    digits = n.to_s.split('').map(&:to_i)
    digit_square_sum = digits.map{|d| d * d}.inject(:+)
    sqrt = (Math.sqrt(digit_square_sum) + 0.4999).to_i
    if digit_square_sum == sqrt * sqrt
      print "#{n}, "
      sum = (sum + n) % mod
    end
  end
  sum
end

p brute_force(10 ** 3)