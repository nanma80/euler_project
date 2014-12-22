require '../../common'

def change_direction(old_direction)
  case old_direction
  when [1, 0]
    [0, 1]
  when [0, 1]
    [-1, 0]
  when [-1, 0]
    [0, -1]
  when [0, -1]
    [1, 0]
  end
end

def next_coordinates(coordinates, direction)
  [coordinates, direction].transpose.map {|x| x[0] + x[1]}
end

def spiral(max_number)
  number = 1
  coordinates = [0, 0]
  direction = [1, 0]
  layer = 0

  while number <= max_number
    yield [number, coordinates, direction, layer]

    new_coordinates = next_coordinates(coordinates, direction)
    new_layer = new_coordinates.map(&:abs).max

    if new_layer > layer
      if coordinates == [layer, - layer]
        layer += 1
        coordinates = new_coordinates
      else
        direction = change_direction(direction)
        coordinates = next_coordinates(coordinates, direction)
      end
    else
      coordinates = new_coordinates
    end
    number += 1
  end
end

def spiral_diagonal_old(max_layer)
  cache = []
  current_layer = 0

  spiral((2 * max_layer + 1) ** 2) do |a|
    if a.last == current_layer
      cache << a.first if a[1][0].abs == a[1][1].abs
    else
      yield [cache, current_layer * 2 + 1]
      cache = []
      current_layer = a.last
      cache << a.first if a[1][0].abs == a[1][1].abs
    end
  end
end

def spiral_diagonal(max_layer)
  cache = [ 1 ]
  max_layer.times do |index|
    number = cache.last
    size = index * 2 + 3
    step = size - 1
    yield [ cache, index * 2 + 1 ]
    cache = [number + step, number + 2* step, number + 3 * step, number + 4 * step]
  end
end

count_all = 0
count_primes = 0

# spiral_diagonal_old(5) do |c|
#   p c
# end

# spiral_diagonal(5) do |c|
#   p c
# end


spiral_diagonal(30000) do |c|
  diags = c[0]
  size = c[1]

  count_all += diags.length
  diags.each do |i|
    count_primes += 1 if i.is_prime?
  end

  percentage = 100.0 * count_primes / count_all
  # p [percentage, size, c] if size % 1000 == 1
  if 1.0 * count_primes / count_all < 0.1 && size > 1
    p size
    exit
  end
end
