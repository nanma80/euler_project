def case1(limit)
  f_values = []
  (1..limit).each do |n|
    delta = 5 * n * n - 1
    delta_sqrt = (Math.sqrt(delta) + 0.5).to_i
    if delta_sqrt ** 2 == delta
      m = 2 * n + delta_sqrt
      f = 4 * m * n - 1
      p [n, f]
      f_values << f
    end
  end
  f_values
end

def case2(limit)
  f_values = []
  (1..limit).each do |n|
    delta = 5 * n * n + 4
    delta_sqrt = (Math.sqrt(delta) + 0.5).to_i
    if delta_sqrt ** 2 == delta
      m = (n + delta_sqrt) / 2
      f = m * n
      p [n, f]
      f_values << f
    end
  end
  f_values
end

def both_cases(limit)
  f_values = (case1(limit) + case2(limit)).sort.uniq
  p f_values
  p f_values.length
  p f_values[9]
  p f_values[14]
end

both_cases(10 ** 6)