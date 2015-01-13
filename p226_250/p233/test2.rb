limit = 10

(-limit..limit-1).each do |m|
  (m+1..limit).each do |n|
    next if (m - n) % 2 == 0
    next if m == 0 || n == 0
    a = (m * m + 2 * m * n - n * n).abs
    b = (- m * m + 2 * m * n + n * n).abs
    c = m * m + n * n
    
    a, b = b, a if a > b
    p [a, b, c]

  end
end
