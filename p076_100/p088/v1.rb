def k_value_pair(array)
  product = array.inject(:*)
  sum = array.inject(:+)
  if product < sum
    return nil, nil
  else
    k = array.length + (product - sum)
    return k, product
  end
end

def each_array(product_limit)
  length_limit = Math.log(product_limit, 2).to_i

  
end

k_limit = 12
product_limit = 2 * k_limit


min_value = {}
(2..12).each do |n|
  k, value = k_value_pair([2, n])
  next if k.nil?
  if k < k_limit && (min_value[k].nil? || min_value[k] > value)
    min_value[k] = value
  end
end

p min_value