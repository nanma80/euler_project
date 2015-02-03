require '../../common'

def modular_sqrt(a, p)
  if legendre_symbol(a, p) != 1
    return 0
  elsif a == 0
    return 0
  elsif p == 2
    return p
  elsif p % 4 == 3
    return a.mod_pow((p + 1) / 4, p)
  end

  s = p - 1
  e = 0
  while s % 2 == 0
    s /= 2
    e += 1
  end

  n = 2
  while legendre_symbol(n, p) != -1
    n += 1
  end

  x = a.mod_pow((s + 1) / 2, p)
  b = a.mod_pow(s, p)
  g = n.mod_pow(s, p)
  r = e

  while true
    t = b
    m = 0
    while m < r
      break if t == 1
      t = t.mod_pow(2, p)
      m += 1
    end

    if m == 0
      return x
    end

    gs = g.mod_pow(2 ** (r - m - 1), p)
    g = (gs * gs) % p
    x = (x * gs) % p
    b = (b * g) % p
    r = m
  end
end

def legendre_symbol(a, p)
  ls = a.mod_pow((p - 1) / 2, p)
  if ls == p - 1
    -1
  else
    ls
  end
end
