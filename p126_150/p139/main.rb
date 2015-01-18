def coprime(a, b)
  gcd(a, b) == 1
end

def gcd(a, b)
  return gcd(b, a) if a < b
  return a if b == 0
  gcd(b, a % b)
end

def triplet(m, n)
  a = m * m - n * n
  b = 2 * m * n
  c = m * m + n * n
  if a < b
    [a, b, c]
  else
    [b, a, c]
  end
end

def each_primary_triplet(perimeter_limit)
  n_limit = Math.sqrt(perimeter_limit / 4).to_i
  (1..n_limit).each do |n|
    n_parity = n % 2
    (n + 1..perimeter_limit).each do |m|
      next if (m % 2) == n_parity
      break if 2 * m * m + 2 * m * n >= perimeter_limit
      primary_triplet = triplet(m, n)
      next if primary_triplet[2] % (primary_triplet[1] - primary_triplet[0]) != 0
      next unless coprime(m, n)
      yield primary_triplet
    end
  end
end

def main
  limit = 10 ** 8
  count = 0
  each_primary_triplet(limit) do |primary_triplet|
    perimeter = primary_triplet.inject(:+)
    count += (limit - 1) / perimeter
  end
  p count
end

main

# perimeter = 2m^2 + 2mn
# m > n
# when m= n perimeter = 4n^2
