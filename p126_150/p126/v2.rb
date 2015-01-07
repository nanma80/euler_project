def has_solution?(a, b, c, n)
  # Check if there's a positive x such that a x^2 + b x + c = n
  sqrt_delta = Math.sqrt( b * b - 4.0 * a * (c - n))
  return false if sqrt_delta < 0
  solutions = [(- b + sqrt_delta)/2/a, (- b - sqrt_delta)/2/a]
  solutions.each do |solution|
    if solution.to_i == solution && solution >= 0
      return true
    end
  end
  false
end

def each_cuboid(limit)
  (1..limit).each do |a|
    (a..2 * limit).each do |b|
      (b..3 * limit).each do |c|
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

def count(number, limit)
  count = 0
  each_cuboid(limit) do |core|
    c = 2 * (core[0] * core[1] + core[1] * core[2] + core[0] * core[2])
    next if c > number
    a = 4
    b = 4 * core.inject(:+) - 4

    if has_solution?(a, b, c, number)
      count += 1
    end
  end
  count
end

target = 1000
limit = 200

range = [37298, 25742, 30638, 50954, 32690, 43946, 36796, 40412, 36996, 38596, 37596, 41510, 18942, 33366, 39926, 45098, 46100, 21160, 57428, 21640, 37036, 62564, 62780, 190148, 236108, 224114, 250828, 251644, 224450, 215690, 237988, 262664, 237506, 261766, 217700, 250348, 248068, 275218, 263768, 254410, 279874, 278130, 271098, 265674, 256328, 258652, 272994, 305022, 289594, 276896, 286184, 269000, 297696, 267012, 250884, 293160, 285498, 278896, 290320, 266288, 281672, 256180, 314472, 297720, 297504, 300744, 297240].sort

range.each do |n|
  next unless n % 2 == 0
  count = count(n, limit)
  p [n, count]
  if count == target
    puts "Found: #{n}"
    break
  end
  # break
end

