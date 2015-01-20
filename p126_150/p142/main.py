from sets import Set

def pair(m, n):
  # m, n should have the same parity
  # m > n
  m_sq = m * m
  n_sq = n * n
  return ((m_sq + n_sq)/2, (m_sq - n_sq)/2)

def buffer(limit):
  buffer_list = {}
  buffer_set = {}
  for m in xrange(1, limit):
    for n in xrange(m+1, limit):
      if (n - m) % 2 == 0:
        a, b = pair(n, m)
        buffer_list.setdefault(a, []).append(b)
        buffer_set.setdefault(a, Set()).add(b)

  for (x, list_y) in buffer_list.iteritems():
    list_y.sort(reverse = True)
  return buffer_list, buffer_set

def main():
  limit = 1000
  buffer_list, buffer_set = buffer(limit)
  for (x, list_y) in buffer_list.iteritems():
    if len(list_y) == 1:
      continue
    for index_y, y in enumerate(list_y):
      for index_z in xrange(index_y + 1, len(list_y)):
        z = list_y[index_z]
        if (y not in buffer_set) or (z not in buffer_set[y]):
          continue
        print x + y + z

main()