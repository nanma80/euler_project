# require 'set'
require '../../common'

def remainders(low, high)
  output = {}
  (low/2..high/2).each do |i|
    number = i + i - 1
    next if number % 5 == 0
    output[number] = 10
  end

  Prime::Cache.new(high).primes.each do |prime|
    output.delete(prime)
  end

  output
end

step_limit = 2 * (10 ** 4)
number_upper_limit = step_limit
number_lower_limit = 4 # (1 * step_limit).to_i

# step_limit = 1000
# number_lower_limit = 4
# number_upper_limit = step_limit

remainders = remainders(number_lower_limit, number_upper_limit)

output = []

(1..step_limit).each do |step|
  puts "#{step}: #{remainders.length}" if step % 10000 == 0
  # p [step, remainders]
  remainders.each do |number, remainder|
    if remainder == 1
      remainders.delete(number)
      if (number - 1) % step == 0
        output << number
      end
    else
      remainders[number] = (remainder * 10) % (number * 9)
    end
  end

  if remainders.empty?
    puts "Empty after #{step} iterations"
    break
  end
end
output.sort!

puts "Upper bound: #{number_upper_limit}"
puts "Lower bound: #{number_lower_limit}"
# p remainders.keys.sort[0..10]

p output.length
if output.length >= 25
  p output[0..24].inject(:+)
end