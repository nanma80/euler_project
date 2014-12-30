def count(m, n)
  m * (m + 1) / 2 * n * (n + 1) / 2
end

limit = 100

min_distance = nil
min_area = nil
min_mn = []

(2..limit).each do |m|
  (2..m).each do |n|
    count = count(m, n)
    distance = (2_000_000 - count).abs
    if min_distance.nil? || min_distance > distance
      min_mn = [m, n]
      min_distance = distance
      min_area = m * n
    end
  end
end

puts min_area