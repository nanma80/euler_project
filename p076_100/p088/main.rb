require './integer'
require 'set'
require 'pp'

def each_factoring(factors, output_set)
  return nil unless factors.length > 1
  output_set << factors
  factors.each_with_index do |a, index_1|
    (0..(index_1 - 1)).each do |index_2|
      b = factors[index_2]
      new_factors = factors.dup
      new_factors.delete_at(index_1)
      new_factors.delete_at(index_2)
      new_factors << a * b
      each_factoring(new_factors, output_set)
    end
  end
end

def all_factoring(number)
  output = Set.new
  each_factoring(number.factors, output)
  output
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

k_limit = 120
product_limit = 2 * k_limit

min_value = {}
(4..product_limit).each do |product|
  p product
  all_factoring(product).each do |factoring|
    k, value = k_value_pair(factoring, product)
    next if k.nil?
    if k < k_limit && (min_value[k].nil? || min_value[k] > value)
      min_value[k] = value
    end
  end
end


p min_value.values.uniq

