require '../../common'

class Integer
  def factors
    n = self
    factors = []
    factor = 2
    exponent = 0
    while n > 1
      if n % factor == 0
        n = n / factor
        exponent += 1
      else
        factors << [factor, exponent] unless exponent == 0
        exponent = 0
        factor += 1
      end
    end
    factors << [factor, exponent] unless exponent == 0
    factors.transpose
  end
end

def solution_count(n)
  factors = n.factors
  exponents = factors.last
  (exponents.inject(1) {|mem, var| mem *= (2 * var + 1)} + 1)/2
end

def array_count(array, primes)
  value = 1
  count = 1
  array.each_with_index do |elem, index|
    count *= (2 * elem + 1)
    value *= (primes[index] ** elem)
  end
  count = (count + 1)/2
  return value, count
end

def each_array(upper_bounds)
  generator = 1
  upper_bounds.each do |upper_bound|
    generator *= upper_bound
  end
  
  (0..(generator - 1)).each do |gen|
    output = []
    upper_bounds.each_with_index do |upper_bound|
      output << gen % upper_bound
      gen = gen / upper_bound
    end
    yield output
  end
end

primes = Prime::Cache.new(100).primes
upper_bounds = [5, 5, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3]
threshold = 4 * (10**6)
min_value = nil

each_array(upper_bounds) do |array|
  value, count = array_count(array, primes)
  if count > threshold && (min_value.nil? || min_value > value)
    min_value = value
    p [value, count, array]
  end
end

puts "Minimum value: #{min_value}"

# [9350130049860600, 4018613, [3, 3, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0]]