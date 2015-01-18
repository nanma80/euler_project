def case1(limit)
  l_values = []
  (1..limit).each do |n|
    deltas = [5 * n * n - 1, 5 * n * n + 1]
    deltas.each do |delta|
      delta_sqrt = (Math.sqrt(delta) + 0.5).to_i
      if delta_sqrt ** 2 == delta
        m = 2 * n + delta_sqrt
        l = m * m + n * n
        p [n, l]
        l_values << l
      end
    end
  end
  l_values
end

l_values = case1(10 ** 7)
p l_values
p l_values.length
if l_values.length >= 12
  p l_values[0..11].inject(:+)
end