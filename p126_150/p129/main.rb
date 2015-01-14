# require 'set'

def remainders(low, high)
  output = {}
  (low/2..high/2).each do |i|
    number = i + i - 1
    next if number % 5 == 0
    output[number] = 10
  end
  output
end


step_limit = 10 ** 6
number_upper_limit = (1.001 * step_limit).to_i
number_lower_limit = (1 * step_limit).to_i

# step_limit = 100
# number_lower_limit = 4
# number_upper_limit = 100

remainders = remainders(number_lower_limit, number_upper_limit)

(1..step_limit).each do |step|
  puts "#{step}: #{remainders.length}" if step % 10000 == 0
  # p [step, remainders]
  remainders.each do |number, remainder|
    if remainder == 1
      remainders.delete(number)
    else
      remainders[number] = (remainder * 10) % (number * 9)
    end
  end

  if remainders.empty?
    puts "Empty after #{step} iterations. Consider increase number_limit"
    break
  end
end

puts "Upper bound: #{number_upper_limit}"
puts "Lower bound: #{number_lower_limit}"
p remainders.keys.sort[0..10]
