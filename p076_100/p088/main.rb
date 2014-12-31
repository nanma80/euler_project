require './integer'
require 'set'
require 'pp'

@cache = {}
@timer = [0.0] * 3

def each_factoring(factors)
  return Set.new if factors.length < 2

  return @cache[factors] unless @cache[factors].nil?

  output = Set.new
  output << factors
  factors.each_with_index do |a, index_1|
    (0..(index_1 - 1)).each do |index_2|
      start_timer = Time.new
      b = factors[index_2]
      new_factors = factors.dup
      new_factors.delete_at(index_1)
      new_factors.delete_at(index_2)
      next if new_factors.empty?
      new_factors << a * b
      new_factors.sort!
      @timer[0] += Time.new - start_timer

      subset = each_factoring(new_factors)

      start_timer = Time.new
      subset.each do |factoring|
        output << factoring
      end
      @timer[1] += Time.new - start_timer
    end
  end
  @cache[factors] = output
  output
end

def all_factoring(number)
  
  factors = number.factors
  
  all_factoring = each_factoring(factors)
  all_factoring
end

def k_value_pair(array, product)
  sum = array.inject(:+)
  if product < sum
    return nil, nil
  else
    k = array.length + (product - sum)
    return k, product
  end
end

def main(k_limit)
  product_limit = 2 * k_limit

  min_value = {}
  (4..product_limit).each do |product|
    p product if product % 100 == 0
    all_factoring(product).each do |factoring|
      k, value = k_value_pair(factoring, product)
      next if k.nil?
      if k <= k_limit && (min_value[k].nil? || min_value[k] > value)
        min_value[k] = value
      end
    end
  end
  
  puts "Sum is #{min_value.values.uniq.inject(:+)}"
end

start_time = Time.new
main(12000)
# output = Set.new
# p each_factoring([2] * 7)

puts "Time elapsed: #{Time.new - start_time}"
p @timer