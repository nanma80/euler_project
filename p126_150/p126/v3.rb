# def has_solution?(a, b, c, n)
#   # Check if there's a positive x such that a x^2 + b x + c = n
#   sqrt_delta = Math.sqrt( b * b - 4.0 * a * (c - n))
#   return false if sqrt_delta < 0
#   solutions = [(- b + sqrt_delta)/2/a, (- b - sqrt_delta)/2/a]
#   solutions.each do |solution|
#     if solution.to_i == solution && solution >= 0
#       return true
#     end
#   end
#   false
# end

# def each_cuboid(limit)
#   (1..limit).each do |a|
#     (a..2 * limit).each do |b|
#       (b..3 * limit).each do |c|
#         yield [a, b, c]
#       end
#     end
#   end
# end

# def cube_count(core, layer)
#   # Example: core = [3, 2, 1]
#   # First layer: layer = 0
#   faces = 2 * (core[0] * core[1] + core[1] * core[2] + core[0] * core[2])
#   edges = 4 * layer * core.inject(:+)
#   corners = 8 * layer * (layer - 1) / 2
#   faces + edges + corners
# end

def count(number, limit)
  count = 0
  (1..limit).each do |core0|
    (core0..2 * limit).each do |core1|
      (0..limit).each do |layer|
        # a * core2 == b
        # core2 >= core1
        b = number -
            4 * layer * (layer - 1) - 
            2 * core0 * core1 - 
            4 * layer * (core0 + core1)
        a = 2 * core1 + 2 * core0 + 4 * layer
        if b % a == 0 && b >= a * core1
          count += 1
        end
      end
    end
  end

  count
end

target = 1000
limit = 150

range = File.read('candidates.txt').split(',').map(&:to_i).sort

range.each do |n|
  next unless n % 2 == 0
  # next unless n > 16000
  count = count(n, limit)
  p [n, count]
  if count == target
    puts "Found: #{n}"
    break
  end
end

