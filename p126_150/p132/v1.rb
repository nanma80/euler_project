# require 'set'
require '../../common'

def remainders(high)
  output = {}
  primes = Prime::Cache.new(high).primes
  primes.each do |prime|
    if prime != 2 && prime != 5
      output[prime] = 1
    end
  end
  output
end

def factors(digit_count, base_exp, remainders, step_size = 1000)
  limit = digit_count
  base = 10 ** base_exp

  multipler_per_step = base ** step_size
  iteration_count = limit / step_size

  puts 'Constructing cache'
  cache = {}
  remainders.keys.each do |number|
    p number
    modulo = number * (base - 1)
    new_remainder = multipler_per_step % modulo
    (1..number-1).each do |remainder|
      cache[[number, remainder]] = new_remainder
      new_remainder = (new_remainder + multipler_per_step) % modulo
    end
  end
  puts 'Cache completed'

  start_time = Time.new
  iteration_count.times do |iteration|
    puts "#{iteration}/#{iteration_count}, #{Time.new - start_time}"

    remainders.each do |number, remainder|
      remainders[number] = cache[[number, remainder]]
    end
  end

  output = []
  remainders.each do |number, remainder|
    if remainder == 1
      output << number
    end
  end

  output.sort!
  output
end

def main
  prime_limit = 1 * (10 ** 4)

  factors = []
  remainders = remainders(prime_limit)

  factors_per_step = factors(10 ** 6, 1, remainders.dup, 10 ** 5)
  factors += factors_per_step

  # factors_per_step = factors(10 ** 3, 10 ** 3, remainders.dup, 10)
  # factors += factors_per_step

  puts "Prime limit: #{prime_limit}"

  factors = factors.uniq.sort
  p factors
  p factors.length
  p factors.inject(:+)
end

start_time = Time.new
main
puts "Time: #{Time.new - start_time} seconds"