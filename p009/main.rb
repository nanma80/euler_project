def verify(a, b, c)
  return c * c - a * a - b * b == 0
end

sum = 1000
limit = sum

(1..limit).each do |a|
  (a..limit).each do |b|
    c = sum - a - b
    if verify(a, b, c)
      puts a * b * c
    end
  end
end

# 31875000

# puts verify(12, 5, 13)