require 'set'

def brute_force(q, n, k)
  q = 1.0 * q
  total = 0.0
  (1..n).to_a.combination(k) do |comb|
    hits = Set.new(comb)
    probability = 1.0
    (1..n).each do |location|
      miss_probability = location / q
      if hits.include?(location)
        probability *= 1 - miss_probability
      else
        probability *= miss_probability
      end
    end
    total += probability
  end
  total
end

def dp(q, n, k)
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
  # p cache
  cache[[n, k]] / (q ** n)
end

q = 5.4
n = 5
k = 3
p (brute_force(q, n, k) - dp(q, n, k))
