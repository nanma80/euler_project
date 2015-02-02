def d(n)
  ideal_k = n / Math::E
  lower_k = ideal_k.to_i
  k_candidates = [lower_k, lower_k + 1]
  log_p_candidates = k_candidates.map {|k| k * Math.log(1.0 * n / k)}

  p_max_index = 0
  current_max = nil
  log_p_candidates.each_with_index do |p_value, p_index|
    if current_max.nil? || p_value > current_max
      current_max = p_value
      p_max_index = p_index
    end
  end

  k = k_candidates[p_max_index]

  each_part = Rational(n, k)

  denominator = each_part.denominator
  [2, 5].each do |prime|
    while denominator % prime == 0
      denominator /= prime
    end
  end
  terminating = (denominator == 1)
  # puts [n, each_part, terminating].join("\t")

  if terminating
    - n
  else
    n
  end
end

limit = 100
limit = 10000
sum = 0
(5..limit).each do |n|
  sum += d(n)
end
p sum
