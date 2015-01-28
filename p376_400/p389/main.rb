def exp(side_count)
  (side_count + 1.0)/2
end

def exp_sq(side_count)
  (side_count + 1.0) * (2.0 * side_count + 1.0) / 6.0
end

def var(side_count)
  exp_sq(side_count) - exp(side_count) ** 2
end

def platonic_sides
  [4, 6, 8, 12, 20]
  # [5, 7, 9]
end

mean = 1.0
var = 0
platonic_sides.each do |side_count|
  new_mean = mean * exp(side_count)
  new_var = mean * var(side_count) + (exp(side_count) ** 2) * var

  mean = new_mean
  var = new_var 
end

p var