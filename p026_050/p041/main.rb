class Integer
  def is_prime?
    factor = 2
    while factor * factor <= self
      return false if self % factor == 0
      factor += 1
    end
    true
  end
end

digit_count = 7
digits = []
(1..digit_count).each do |digit|
  digits << digit.to_s
end

greatest = 0

digits.permutation do |perm|
  number = perm.join.to_i
  if number.is_prime?
    greatest = number if number > greatest
  end
end

puts greatest