# First ten and their sum:
# [81, 512, 2401, 4913, 5832, 17576, 19683, 234256, 390625, 614656]
# 1290535

class Integer
  def digit_sum
    self.to_s.split('').map(&:to_i).inject(:+)
  end

  def good?
    return false if self < 10
    d_sum = digit_sum
    return false if d_sum == 1
    product = d_sum
    until product > self
      if product == self
        return true
      else
        product *= d_sum
      end
    end
    false
  end
end

found = [1]

(2..100).each do |base|
  product = base * base
  50.times do |exp_minus_two|
    if product.digit_sum == base
      found << product
    end
    product *= base
  end
end

found.sort!
p found[30]