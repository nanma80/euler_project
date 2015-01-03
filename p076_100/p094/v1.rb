limit = 10 ** 5
perimeter_sum = 0

(1..limit).each do |base|
  [-1, 1].each do |offset|
    side = base + offset
    next if 2 * side <= base
    # p [side, base]
    height_sq = side * side - base * base / 4.0
    height = Math.sqrt(height_sq)
    next if height * height != height_sq
    area = height * base / 2.0
    next if area.to_i != area
    area = area.to_i
    perimeter = side * 2 + base
    p [side, base, perimeter, area]
    perimeter_sum += perimeter
  end
end

p perimeter_sum

# When limit = 10 ** 5, perimeter_sum = 472915

# [5, 6, 16, 12]
# [17, 16, 50, 120]
# [65, 66, 196, 1848]
# [241, 240, 722, 25080]
# [901, 902, 2704, 351780]
# [3361, 3360, 10082, 4890480]
# [12545, 12546, 37636, 68149872]
# [46817, 46816, 140450, 949077360]
# [93686, 93687, 281059, 3800608366] 
# Last one is incorrect