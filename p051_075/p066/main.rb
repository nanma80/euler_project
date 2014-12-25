require './p064'
require './p065'

class Integer
  def is_square?
    Math.sqrt(self).to_i ** 2 == self
  end
end

def solve(d, approx_level_limit)
  if d.is_square?
    return nil
  end

  cont_frac = fraction(d)
  (1..approx_level_limit).each do |approx_level|
    frac = convergent(cont_frac, approx_level)

    x = frac.num
    y = frac.den
    if x * x - d * y * y == 1
      return x
    end
  end
  raise "d: #{d} exceeds limit #{approx_level_limit}"
end

approx_level_limit = 1000
limit_d = 1000
max_x = 0
max_d = 0

(1..limit_d).each do |d|
  x = solve(d, approx_level_limit)
  next if x.nil?
  p [d, x]
  if x > max_x
    max_x = x
    max_d = d
  end
end
p max_d
