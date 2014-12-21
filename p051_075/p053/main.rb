limit = 100
threshold = 10 ** 6

factorials = [1]
(1..limit).each do |n|
  factorials << factorials.last * n
end

count = 0
(1..limit).each do |n|
  (0..n).each do |r|
    ncr = factorials[n]/factorials[r]/factorials[n - r]
    count += 1 if ncr > threshold
  end
end

p count