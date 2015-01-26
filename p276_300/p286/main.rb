require 'set'

def prob(q, n, k)
  q = 1.0 * q
  cache = {}
  (1..n).each do |current_n|
    (0..current_n).each do |current_k|
      if current_k == 0
        value = (1..current_n).to_a.inject(:*)
      elsif current_k == current_n
        value = (1..current_n).to_a.map {|i| q - i}.inject(:*)
      else
        value = cache[[current_n - 1, current_k]] * current_n + cache[[current_n - 1, current_k - 1]] * (q - current_n)
      end
    cache[[current_n, current_k]] = value
    end
  end
  cache[[n, k]] / (q ** n)
end

def binary_search(n, k, target, q_max, q_min)
  # prob is a decreasing function wrt q, so min and max are swapped
  epsilon = 10.0 ** ( - 15)
  prob_max = prob(q_min, n, k)
  prob_min = prob(q_max, n, k)
  raise if target < prob_min || target > prob_max
  while prob_max - prob_min > epsilon
    q_mid = (q_min + q_max) / 2.0
    prob_mid = prob(q_mid, n, k)
    if prob_mid > target
      q_min = q_mid
    else
      q_max = q_mid
    end

    prob_max = prob(q_min, n, k)
    prob_min = prob(q_max, n, k)
    
    raise if target < prob_min || target > prob_max
  end
  q_max
end


n = 50
k = 20
target = 0.02
p binary_search(n, k, target, 55, 50)