def next_collatz(i)
  if i % 2 == 0
    i / 2
  else
    3 * i + 1
  end
end

limit = 1_000_000

distances = [nil] * (limit + 1)
distances[0] = 1
distances[1] = 1

(1..limit).each do |i|
  next unless distances[i].nil?
  buffer = [i]
  next_number = next_collatz(buffer.last)
  while next_number > limit || distances[next_number].nil?
    buffer << next_number
    next_number = next_collatz(buffer.last)
  end
  
  reached_distance = distances[next_number]
  buffer_length = buffer.length
  buffer.each_with_index do |value, index|
    distances[value] = reached_distance + buffer_length - index if value <= limit
  end
end

max_distance = 1
max_index = 1
distances.each_with_index do |value, index|
  if value > max_distance
    max_distance = value
    max_index = index
  end
end

p max_index
p max_distance