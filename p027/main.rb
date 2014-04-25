def is_prime?(n)
  return false if n < 2
  
  factor = 2
  while factor * factor <= n
    return false if n % factor == 0
    factor += 1
  end
  true
end

def n_consecutive_primes(a, b)
  n = 0
  while is_prime?(n * n + a * n + b)
    n += 1
  end
  return n
end


most_consecutive_primes = 0
best_product = 0

limit = 999

((-limit)..limit).each do |a|
  ((-limit)..limit).each do |b|
    current_n = n_consecutive_primes(a, b)
    if current_n > most_consecutive_primes
      most_consecutive_primes = current_n
      best_product = a * b
    end
  end
end

p best_product
# p most_consecutive_primes