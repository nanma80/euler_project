require 'benchmark'

def count(target, start_value, included, range)
  # p [target, start_value, range]
  epsilon = 10.0 ** (-10)

  if start_value > target + epsilon
    return 0
  end

  if start_value > target - epsilon
    puts "Hit: #{included}"
    return 1
  end

  if range.empty?
    return 0
  end

  max_value = start_value
  range.each do |n|
    max_value += 1.0 / n / n
  end

  if max_value < target - epsilon
    # puts "max < target: #{[target, start_value, range]}"
    return 0
  end

  if max_value > target - epsilon && max_value < target + epsilon
    puts "hit: #{included + range}"
    return 1
  end

  first_in_range = range.first
  new_range = range[1..-1]

  count = 0
  count += count(target, start_value + 1.0/first_in_range/first_in_range, included + [first_in_range], new_range)
  count += count(target, start_value, included, new_range)

  count
end

def main
  range = (2..30).to_a

  p count(0.5, 0, [], range)
end

p Benchmark.measure { main }