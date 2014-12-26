# target = 3 / 7

min_distance = 1.0
min_n = 0
min_d = 1

limit_d = 10 ** 6
(1..limit_d).each do |d|
  n = d * 3 / 7
  next if n * 7 == d * 3 # n/d reduces to 3/7
  next if n * min_d == d * min_n # n/d reduces to min_n/min_d

  distance = 3.0 / 7 - 1.0 * n / d
  if min_distance.nil? || min_distance > distance
    min_distance = distance
    min_n = n
    min_d = d
  end
end

puts min_n
puts '------'
puts min_d
