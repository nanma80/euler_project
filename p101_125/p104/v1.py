def fibonacci_with_index(limit):
  yield 1, 1
  yield 1, 2
  cache = [1, 1]
  for i in xrange(3, limit + 1):
    new_number = cache[0] + cache[1]
    cache.pop(0)
    cache.append(new_number)
    yield new_number, i

def first_9_digits(number):
  return str(number)[:9]

def last_9_digits(number):
  return str(number)[-9:]

def is_pandigital(string):
  l = list(string)
  return (len(l) == 9 and '0' not in l and len(set(l)) == 9)

for fibo, index in fibonacci_with_index(10**5):
  if index % (10**3) == 0:
    print index, len(str(fibo))
  if is_pandigital(first_9_digits(fibo)) and is_pandigital(last_9_digits(fibo)):
    print 'Found: ' + str(index)
    break
