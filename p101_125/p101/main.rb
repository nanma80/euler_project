require 'matrix'

def polynomial(coef, n)
  # coef = [a_0, a_1, a_2, ...]
  sum = 0
  coef.each_with_index do |a, exp|
    sum += a * (n ** exp)
  end
  sum
end

def true_polynomial(n, options)
  if options[:testing]
    coef = [0, 0, 0, 1]
  else
    coef = (0..10).to_a.map {|k| (-1) ** k}
  end
  polynomial(coef, n)
end

def first_n_terms(n, options)
  output = []
  (1..n).each do |k|
    output << true_polynomial(k, options)
  end
  output
end

def next_term(array, k)
  dim = k + 1
  array_first_terms = array[0..k]
  m = Matrix.build(dim, dim) do |row, col|
    (row + 1) ** col
  end

  fitted = (m.inverse * Vector.elements(array_first_terms)).to_a#.map(&:to_f)
  polynomial(fitted, k + 2).to_i
end

testing = false

limit = 15
array = first_n_terms(limit, {testing: testing})

sum = 0
(0..limit - 2).each do |k|
  next_term = next_term(array, k)
  if next_term != array[k + 1]
    sum += next_term
  end
end

p sum
