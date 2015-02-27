def coprime(a, b)
  gcd(a, b) == 1
end

def gcd(a, b)
  return gcd(b, a) if a < b
  return a if b == 0
  gcd(b, a % b)
end

def main
  count = 0
  limit = 10 ** 12
  p_limit = Math.sqrt(Math.sqrt(limit)).to_i
  (1..p_limit).each do |p|
    puts p if p % 1000 == 0
    (1..p-1).each do |q|
      next if (p - q) % 2 == 0
      next unless coprime(p, q)
      # puts [p, q].inspect
      m = p * p - q * q
      n = 2 * p * q
      if m < n
        m, n = n, m
      end
      a = m * m - n * n
      b = 2 * m * n
      area = a * b / 2
      next if (area % 6 == 0 && area % 28 == 0)
      puts [a, b, area].inspect
      count += 2
    end
  end
  p count
end

main