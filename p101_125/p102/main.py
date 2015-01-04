class Point:
  def __init__(self, x, y):
    self.x = x
    self.y = y

def area(p0, p1, p2):
  return p0.x * p1.y + p1.x * p2.y + p2.x * p0.y - p0.y * p1.x - p1.y * p2.x - p2.y * p0.x

def each_triangle():
  filename = 'p102_triangles.txt'

  with open(filename) as f:
    triangle_input = [line.split(',') for line in f.read().splitlines()]

  for input_string in triangle_input:
    input_numbers = [int(number_str) for number_str in input_string]
    triangle = (
      Point(input_numbers[0], input_numbers[1]),
      Point(input_numbers[2], input_numbers[3]),
      Point(input_numbers[4], input_numbers[5])
    )
    yield triangle

origin = Point(0, 0)
inside_count = 0

for triangle in each_triangle():
  inside = True
  total = area(triangle[0], triangle[1], triangle[2])
  total_sign = (total > 0)

  for sub_area in [
      area(triangle[0], triangle[1], origin),
      area(triangle[0], origin, triangle[2]),
      area(origin, triangle[1], triangle[2])
  ]:
    sub_sign = (sub_area > 0)
    if sub_sign != total_sign:
      inside = False
      break
  if inside:
    inside_count += 1

print inside_count
