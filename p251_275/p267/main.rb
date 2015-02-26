require '../../common'

def k_min(n, target)
  k_start = n / 3
  if n % 3 != 0
    k_start += 1
  end

  (k_start..n).each do |k|
    max_target = ((3.0 * k / n) ** k) * ((1.5 * (n - k)/ n) ** (n - k))
    if max_target >= target
      return k
    end
  end
  nil
end

def prob(n, k_min)
  sum = 0
  (k_min..n).each do |k|
    sum += n.choose(k)
  end
  sum = 1.0 * sum / (2 ** n)
end

def max_prob(n, target)
  k_min = k_min(n, target)
  p k_min
  prob(n, k_min)
end

p max_prob(1000, 10 ** 9)