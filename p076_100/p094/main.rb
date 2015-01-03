def candidates(n, mode)
  m_factor = mode ? Math.sqrt(3) : (2.0 + Math.sqrt(3))
  m_low = (m_factor * n).to_i
  m_high = m_low + 1
  
  [m_low, m_high].each do |m|
    next unless m > n && (m - n) % 2 == 1
    (1..10).each do |k|
      c = (m * m + n * n) * k
      next if c % 2 == 1
      a = (m * m - n * n) * k
      b = 2 * m * n * k
      if not mode
        a, b = b, a
      end
      break if (c / 2 - a).abs > 1
      next if (a * b) % 4 != 0
      yield [c/2, c/2, a]
    end
  end
end

perimeter_sum = 0

(1..40000).each do |n|
  [true, false].each do |mode|
    candidates(n, mode) do |sides|
      perimeter = sides.inject(:+)
      if perimeter <= 10 ** 9
        perimeter_sum += perimeter
      end
    end
  end
end


p perimeter_sum