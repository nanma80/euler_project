# b blue discs and (t-b) red discs, with t discs in total
# 2b(b-1) = t(t-1)
# tt - t - 2bb + 2b = 0
# delta = sqrt(1+16bb-16b)
# (1 + delta) % 2 == 0
# ------- above: too slow for this problem -------
# tt + 2b = t + 2bb
# 
# 
# 

# b_min = ((10 ** 12) * Math.sqrt(0.5)).to_i - 10**5
b_min = 2
# b_min = 707106681186
# b_min = 707231000000
b_max = 10 ** 12
# t_threshold = 10 ** 12
t_threshold = 2

p b_min

(b_min..b_max).each do |b|
  puts b if b % (10 ** 6) == 0
  delta_sq = 1 + 8 * b * b - 8 * b
  delta = Math.sqrt(delta_sq).to_i
  next unless delta * delta == delta_sq
  next unless (1 + delta) % 2 == 0
  t = (1 + delta) / 2
  next unless t > t_threshold
  p [b, t]

  # break
end