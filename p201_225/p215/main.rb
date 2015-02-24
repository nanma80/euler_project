require 'pp'
require 'set'
require 'benchmark'

def gaps(layout)
  length = layout.inject(:+) - 1
  gaps = [false] * length
  position = -1
  layout.each do |brick_size|
    position += brick_size
    if position < length
      gaps[position] = true
    end
  end
  gaps
end

def each_layout(n)
  most_bricks = n / 2
  if n % 3 == 0
    least_bricks = n / 3
  else
    least_bricks = n / 3 + 1
  end

  (least_bricks..most_bricks).each do |brick_count|
    generator_limit = 2 ** brick_count
    generator_limit.times do |generator|
      layout = (generator + generator_limit).to_s(2)[1..-1].split('').map {|c| c == '0' ? 2 : 3}
      next unless layout.inject(:+) == n
      yield layout
    end
  end
end

def gap_layouts(n)
  output = []
  each_layout(n) do |layout|
    output << gaps(layout)
  end
  output
end

def valid_map(gap_layouts)
  valid_map = Hash.new { |hash, key| hash[key] = Set.new }
  length = gap_layouts.first.length
  gap_layouts.each_with_index do |gaps1, index1|
    gap_layouts.each_with_index do |gaps2, index2|
      break if index2 == index1
      valid = true
      length.times do |position|
        if gaps1[position] && gaps2[position]
          valid = false
          break
        end
      end

      if valid
        valid_map[index1] << index2
        valid_map[index2] << index1
      end
    end
  end
  valid_map
end

def main
  width = 32
  height = 10
  gap_layouts = gap_layouts(width)
  valid_map = valid_map(gap_layouts)
  
  count = Hash.new(1)

  (2..height).each do |layer|
    new_count = Hash.new { |hash, key| hash[key] = 0 }
    valid_map.each do |from_one, to_multiple|
      from_count = count[from_one]
      to_multiple.each do |to_one|
        new_count[to_one] += from_count
      end
    end
    count = new_count
  end

  total = count.values.inject(:+)
  p total
end

puts Benchmark.measure { main }
