LIMIT = 200 # should be 200
TYPES = [2, 5, 10, 20, 50, 100, 200] # no 1 pence

def value(counts)
  sum = 0
  counts.each_with_index do |count, index|
    sum += count * TYPES[index]
  end
  sum
end

def increment(counts)
  pointer = 0
  while pointer < TYPES.length
    counts[pointer] += 1
    if value(counts) <= LIMIT
      return counts
    end
    counts[pointer] = 0
    pointer += 1
  end
  nil
end

counts = [0] * (TYPES.length)
counter = 1

while increment(counts)
  counter += 1
end

puts counter