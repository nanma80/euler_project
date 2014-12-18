
def digit_sum(number, exponent)
  digits = number.to_s.split('').map{|c| c.to_i}
  digit_powers = digits.map{|d| d ** exponent}
  digit_powers.inject(0) { |mem, var|  mem += var}
end

exponent = 5
sum = 0
(2..(10**(exponent+1) )).each do |number|
  if number == digit_sum(number, exponent)
    sum += number
  end
end

puts sum