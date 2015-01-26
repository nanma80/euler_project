require '../../common'

def x_values(n)
  exponent = 3
  output = []
  (2..n).each do |k|
    if (k ** exponent) % n == 1
      output << k
    end
  end
  output
end

(1..100).each do |n|
  x_values = x_values(n)
  unless x_values.empty?
    p [n, x_values, x_values.inject(0) { |mem, var|  mem + var}]
  end
end