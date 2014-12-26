def trunc(n, digits = 10)
  str = n.to_s
  if str.length < digits
    n
  else
    str[(- digits)..(-1)].to_i
  end
end

def powers_of_2(limit = 30)
  powers_of_2 = {}

  exponent = 1
  power = 2

  limit.times do
    powers_of_2[exponent] = power
    exponent *= 2
    power = trunc(power ** 2)
  end
  powers_of_2
end

def power_of_2(exponent)
  powers = powers_of_2
  binary = exponent.to_s(2).split('').map(&:to_i)
  binary_length = binary.length
  output = 1
  binary.each_with_index do |digit, index|
    next if digit == 0
    digit_power = 2 ** (binary_length - 1 - index)
    output = trunc(output * powers_of_2[digit_power])
  end
  output
end

p trunc(power_of_2(7830457) * 28433 + 1)
