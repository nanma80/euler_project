require 'pp'

def test_triangle
  [
    [15],
    [-14, -7],
    [20, -13, -5],
    [-3, 8, 23, -26],
    [1, -4, -5, -18, 5],
    [-16, 31, 2, 9, 28, 3]
  ]
end

def sequence(limit)
  t = 0
  two_20 = 2 ** 20
  two_19 = 2 ** 19
  seq = []
  limit.times do
    t = (615949 * t + 797807) % two_20
    seq << (t - two_19)
  end
  seq
end

def triangle(depth)
  triangle = []
  sequence = sequence(depth * (depth + 1) / 2)
  pointer = 0
  depth.times do |layer|
    row = []
    (layer + 1).times do
      row << sequence[pointer]
      pointer += 1
    end
    triangle << row
  end
  triangle
end

def min_sum(triangle)
  min_sum = 0
  depth = triangle.length
  (0..depth - 1).to_a.reverse_each do |bottom|
    print "Bottom: #{bottom}\r"
    cache = Hash.new(0)
    (0..bottom).to_a.reverse_each do |top|
      (0..top).each do |left|
        value = cache[[top + 1, bottom, left]] +
          cache[[top + 1, bottom, left + 1]] -
          cache[[top + 2, bottom, left + 1]] +
          triangle[top][left]
        cache[[top, bottom, left]] = value
        if value < min_sum
          min_sum = value
        end
      end
    end
  end
  puts
  p min_sum
end

# min_sum(test_triangle)
min_sum(triangle(1000))
