def gcd(a, b)
  return gcd(b, a) if a < b
  return a if b == 0
  gcd(b, a % b)
end

def area(a)
  area = 0.0
  each_pair(a) do |pair|
    area += pair[0] * pair[1]
  end
  area /= 2
  area
end

def boundary(a)
  boundary = 0
  each_pair(a) do |pair|
    boundary += gcd(pair[0], pair[1])
  end
  boundary
end

def each_pair(a)
  length = a.length
  length.times do |index|
    yield [a[index], a[(index + 1) % length]]
  end
end

def internal_points(a)
  area(a) + 1 - boundary(a) / 2.0
end

def each_array(m)
  (1..m).each do |a|
    puts a
    (1..m).each do |b|
      (1..m).each do |c|
        (1..m).each do |d|
          yield [ a, b, c, d ]
        end
      end
    end
  end
end

def is_square(float)
  int = float.to_i
  if int != float
    return false
  end

  sqrt = Math.sqrt(float)
  sqrt_int = (sqrt + 0.5 - 0.000001).to_i
  (sqrt_int * sqrt_int) == int
end


m = 100
count = 0
each_array(m) do |array|
  count += 1 if is_square(internal_points(array))
end

p count
