LIMIT = 2000

def is_pentagonal?(k)
  delta_sqrt = Math.sqrt(24 * k + 1)
  delta_sqrt.to_i == delta_sqrt && 
    ((1 + delta_sqrt) % 6 == 0 || 
      ((1 - delta_sqrt) % 6 == 0) && (1 - delta_sqrt) > 0)
end

def pentagonal(n)
  n * (3 * n - 1)/2
end

(1..LIMIT).each do |n1|
  p1 = pentagonal(n1)
  ((n1 + 1)..LIMIT).each do |n2|
    p2 = pentagonal(n2)
    sum = p1 + p2
    if sum < pentagonal(n2 + 1)
      break
    end

    next unless is_pentagonal?(sum)

    sum2 = p1 * 2 + p2
    if is_pentagonal?(sum2)
      p [pentagonal(n1), pentagonal(n2), sum, sum2]
      exit
    end
  end
end

# 5482660

