def sum(n, r)
  ((900 - 3 * n) * (r ** n) - 897.0) / (r - 1.0) +
  3.0 * r * (r ** (n - 1) - 1.0) / (r - 1.0) ** 2
end

def binary_search(n, target, r_max, r_min)
  # sum is a decreasing function wrt r, so min and max are swapped
  epsilon = 10.0 ** ( - 15)
  sum_max = sum(n, r_min)
  sum_min = sum(n, r_max)
  # p [sum_max, sum_min, target]
  raise if target < sum_min || target > sum_max
  while r_max - r_min > epsilon
    r_mid = (r_min + r_max) / 2.0
    sum_mid = sum(n, r_mid)
    if sum_mid > target
      r_min = r_mid
    else
      r_max = r_mid
    end

    sum_max = sum(n, r_min)
    sum_min = sum(n, r_max)
    # p [sum_max, sum_min, target]

    raise if target < sum_min || target > sum_max
  end
  r_max
end

r = 1.0007
n = 5000
# p sum(n, r)

# target = - 471132171.5280229
target = - 6.0 * (10 ** 11)

r_max = 1.005
r_min = 1.0005

p binary_search(n, target, r_max, r_min)

