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

# def increment(counts)
#   pointer = 0
#   while pointer < TYPES.length
#     counts[pointer] += 1
#     if value(counts) <= LIMIT
#       return counts
#     end
#     counts[pointer] = 0
#     pointer += 1
#   end
#   nil
# end

def solution_count(n)
  factors = n.factors
  uniq_factors = factors.first
  exponents = factors.last
  count = 0
  
  generator = 1
  exponents.each do |exponent|
    generator *= (2 * exponent + 1)
  end
  
  (0..(generator - 1)).each do |gen|
    value = 1
    exponents.each_with_index do |exponent, index|
      exp = gen % (2 * exponent + 1)
      value *= uniq_factors[index] ** exp
      gen = gen / (2 * exponent + 1)
    end
    count += 1 if value <= n
  end
  count
end

def brute_force_count(n)
  n_sq = n * n
  count = 0
  (1..n).each do |k|
    count += 1 if n_sq % k == 0
  end
  count
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

# (2..10).each do |n|
#   p [n, solution_count(n)]
# end