require '../../common'

def modular_sqrt(a, p)
  if p % 4 == 3
    return a.mod_pow((p + 1) / 4, p)
  end

  s = p - 1
  e = 0
  while s % 2 == 0
    s /= 2
    e += 1
  end

  n = 2
  while n.mod_pow((p - 1) / 2, p) != (p - 1)
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
      t = (t * t) % p
      m += 1
    end

    if m == 0
      return x
    end

    gs = (g ** (2 ** (r - m - 1))) % p
    g = (gs * gs) % p
    x = (x * gs) % p
    b = (b * g) % p
    r = m
  end
end