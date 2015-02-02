def product(m)
  den = (1..m).to_a.inject(:+)
  product = 1.0
  (1..m).each do |running_m|
    x_m = 1.0 * m * running_m / den
    product *= x_m ** running_m
  end
  product.to_i
end

products = (2..15).to_a.map do |m|
  product(m)
end

p products.inject(:+)
