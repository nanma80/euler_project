def gcd(a, b)
  return gcd(b, a) if a < b
  return a if b == 0
  gcd(b, a % b)
end

def lcm(a, b)
  a * b / gcd(a, b)
end

limit = 20
lcm_all = 1

for i in 1..limit
  lcm_all = lcm(i, lcm_all)
end

puts lcm_all # 232792560