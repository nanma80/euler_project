def sum_brute_force(n, r)
  sum = 0.0
  (1..n).each do |k|
    sum += (900 - 3 * k) * (r ** (k - 1))
  end
  sum
end

def sum(n, r)
  ((900 - 3 * n) * (r ** n) - 897.0) / (r - 1.0) +
  3.0 * r * (r ** (n - 1) - 1.0) / (r - 1.0) ** 2
end

p sum_brute_force(10, 2.0)
p sum(10, 2.0)