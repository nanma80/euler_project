def fibo_ends_with_index(limit):
  yield '1', '1', 1
  yield '1', '1', 2
  end_cache = [1, 1]
  front_cache = [0.1, 0.1]
  for i in xrange(3, limit + 1):
    end_number = (end_cache[0] + end_cache[1]) % (10 ** 9)
    end_cache.pop(0)
    end_cache.append(end_number)

    front_number = (front_cache[0] + front_cache[1])
    if front_number > 1.0:
      front_number /= 10.0
      front_cache[1] /= 10.0
    front_cache.pop(0)
    front_cache.append(front_number)

    front_digits = str(front_number)[2:11]
    yield (front_digits, str(end_number), i)

def is_pandigital(string):
  l = list(string)
  return (len(l) == 9 and '0' not in l and len(set(l)) == 9)

for (front, end, index) in fibo_ends_with_index(10 ** 6):
  if is_pandigital(front) and is_pandigital(end):
    print 'Found: ' + str(index)
    break
