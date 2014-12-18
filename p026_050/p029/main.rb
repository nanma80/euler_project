LIMIT = 100
numbers = {}

(2..LIMIT).each do |a|
  (2..LIMIT).each do |b|
    numbers[a**b] = true
  end
end

puts numbers.keys.length