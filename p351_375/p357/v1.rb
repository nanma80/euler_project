require '../../common'

limit = 10 ** 2
sum = 0
prime_cache = Prime::Cache.new(limit)
(1..limit).each do |n|
  is_good = true
  (1..Math.sqrt(n)).each do |d|
    next if n % d != 0
    if !prime_cache.is_prime?(d + n / d)
      is_good = false
      break
    end
  end
  if is_good
    sum += n
    p n
  end
end
p sum

# 401 for 100
# 524402305 for 10 ** 6
