limit = 100
(1..limit-1).each do |a|
  (a+1..limit).each do |b|
    if (2 * a * b) % (a + b) == 0
      n = a + b - (2 * a * b) / (a + b)
      next if 2 * a - n <= 0 || 2 * b - n <= 0
      # p [a, b, 2*a*b, a+b, (b % a == 0), b/a]
      # p [a, b, (2 * a * b) / (a + b)]
      p [2 * a - n, 2 * b - n, n]
    end
  end
end