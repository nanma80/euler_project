limit = 10 ** 6
outside_limit = (limit + 4) / 4

count = Hash.new { |hash, key| hash[key] = 0 }

(3..outside_limit).each do |outside|
  outside_sq = outside ** 2
  inside = outside - 2

  while inside > 0
    tile_count = outside_sq - inside * inside
    if tile_count > limit
      break
    end
    count[tile_count] += 1
    inside -= 2
  end
end

sum = 0
count.each do |tile_count, shape_count|
  if shape_count <= 10
    sum += 1
  end
end

p sum