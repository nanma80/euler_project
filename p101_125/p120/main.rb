def r_max(a)
  case (a % 4)
  when 1, 3
    (a - 1) * a
  when 0, 2
    (a - 2) * a
  end
end

def brute_force(a)
  limit = 1000
  r_max = nil

  (1..limit).each do |n|
    r = ((a - 1) ** n + (a + 1) ** n) % (a * a)
    if r_max.nil? || r_max < r
      r_max = r
    end
  end
  r_max
end

sum = 0
(3..1000).each do |n|
  sum += r_max(n)
end
p sum