def each_cuboid(limit)
  (1..limit).each do |a|
    (a..limit).each do |b|
      (b..limit).each do |c|
        yield [a, b, c]
      end
    end
  end
end

def cube_count(core, layer)
  # Example: core = [3, 2, 1]
  # First layer: layer = 0
  faces = 2 * (core[0] * core[1] + core[1] * core[2] + core[0] * core[2])
  edges = 4 * layer * core.inject(:+)
  corners = 8 * layer * (layer - 1) / 2
  faces + edges + corners
end


count_cache = {}
target = 1000
loop_count = 0
limit = 200

each_cuboid(limit) do |cuboid|
  loop_count += 1
  print "#{cuboid}\r" if loop_count % 1000 == 0
  (0..limit).each do |layer|
    count = cube_count(cuboid, layer)
    count_cache[count] = (count_cache[count] || 0) + 1
  end
end

puts

target_count = []
max_appearance = 0
count_cache.each do |count, appearance|
  if appearance == target
    target_count << count
  end

  if appearance > max_appearance
    max_appearance = appearance
  end
end

p target_count.min
p max_appearance

# 23682 incorrect
