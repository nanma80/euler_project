class Integer
  def factors
    n = self
    factors = []
    factor = 2
    exponent = 0
    while n > 1
      if n % factor == 0
        n = n / factor
        exponent += 1
      else
        factors << [factor, exponent] unless exponent == 0
        exponent = 0
        factor += 1
      end
    end
    factors << [factor, exponent] unless exponent == 0
    factors.transpose
  end
end

def solution_count(n)
  factors = n.factors
  exponents = factors.last
  (exponents.inject(1) {|mem, var| mem *= (2 * var + 1)} + 1)/2
end

threshold = 1000
((10 ** 5)..(10 ** 6)).each do |n|
  count = solution_count(n)
  p [n, count] if count > 600

  if count > threshold
    p n
    break
  end
end
