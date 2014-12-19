LIMIT = 50000

def has_solution?(a, b, c, n)
  # Check if there's a positive x such that a x^2 + b x + c = n
  sqrt_delta = Math.sqrt( b * b - 4.0 * a * (c - n))
  return false if sqrt_delta < 0
  solutions = [(- b + sqrt_delta)/2/a, (- b - sqrt_delta)/2/a]
  solutions.each do |solution|
    if solution.to_i == solution && solution > 0
      return true
    end
  end
  false
end

def is_triangle?(n)
  has_solution?(1.0/2, 1.0/2, 0.0, n)
end

def is_pentagonal?(n)
  has_solution?(3.0/2, -1.0/2, 0.0, n)
end

def is_hexagonal?(n)
  has_solution?(2.0, -1.0, 0.0, n)
end

def hexagonal_numbers(limit)
  (1..limit).each do |n|
    yield n * (2 * n - 1)
  end
end

hexagonal_numbers(LIMIT) do |n|
  if is_triangle?(n) && is_pentagonal?(n)
    puts n
  end
end