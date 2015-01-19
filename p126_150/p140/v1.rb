require 'matrix'

def next_term(array, k)
  dim = k + 1
  array_first_terms = array[0..k]
  m = Matrix.build(dim, dim) do |row, col|
    (row + 1) ** col
  end

  fitted = (m.inverse * Vector.elements(array_first_terms)).to_a
  array_first_terms + [polynomial(fitted, k + 2).to_i]  
end

def polynomial(coef, n)
  # coef = [a_0, a_1, a_2, ...]
  sum = 0
  coef.each_with_index do |a, exp|
    sum += a * (n ** exp)
  end
  sum
end

def check(f)
  sq_check = 5 * f * f + 14 * f + 1
  root_check = (Math.sqrt(sq_check) + 0.5).to_i
  root_check * root_check == sq_check
end

limit = 10 ** 5
count = 1
terms = []
(1..limit).each do |f|
  if check(f)
    puts "#{count}: #{f}"
    count += 1
    terms << f
  end
end

p terms
p next_term(terms, 7)
