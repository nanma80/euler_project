def modified_collatz(n, limit)
  output = ''
  limit.times do
    case n % 3
    when 0
      n /= 3
      output << 'D'
    when 1
      n = (4 * n + 2) / 3
      output << 'U'
    when 2
      n = (2 * n - 1) / 3
      output << 'd'
    end
  end
  output
end

def mod(sequence)
  3 ** (sequence.length)
end

def remainder(sequence)
  remainder = 0
  sequence.split('').reverse.each_with_index do |map, index|
    i = index
    case map
    when 'D'
      remainder = 3 * remainder
    when 'd'
      remainder_numerator = 0
      remainder_denominator = 2
      remainder_denominator.times do |m|
        remainder_numerator = 3 * remainder + m * (3 ** (i + 1)) + 1
        if remainder_numerator % remainder_denominator == 0
          break
        end
      end
      remainder = (remainder_numerator / remainder_denominator) % (3 ** (i + 1))
    when 'U'
      remainder_numerator = 0
      remainder_denominator = 4
      remainder_denominator.times do |m|
        remainder_numerator = 3 * remainder + m * (3 ** (i + 1)) - 2
        if remainder_numerator % remainder_denominator == 0
          break
        end
      end
      remainder = (remainder_numerator / remainder_denominator) % (3 ** (i + 1))
    end
  end
  remainder
end

def mod_above(mod, remainder, above)
  mod - (above + mod) % mod + remainder + above
end

def main
  # sequence = 'DdDddUUdDD'
  sequence = 'UDDDUdddDDUDDddDdDddDDUDDdUUDd'
  above = 10 ** 15
  mod = mod(sequence)
  remainder = remainder(sequence)
  n = mod_above(mod, remainder, above)
  p n
  
  check = modified_collatz(n, sequence.length)

  if sequence != check
    puts 'wrong!'
  end
end

main