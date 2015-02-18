from fractions import Fraction
import time

class Agent:
  def __init__(self, limit):
    self.values = {}
    self.limit = limit
    self.populate_values()

  def populate_values(self):
    self.values[1] = set([Fraction(1, 1)])
    tick = time.time()
    for n in xrange(2, self.limit + 1):
      new_set = set()
      for k in xrange(1, n / 2 + 1):
        for value_k in self.values[k]:
          for value_n_minus_k in self.values[n - k]:
            parallel_value = value_k + value_n_minus_k
            series_value = 1/(1/value_k + 1/value_n_minus_k)

            new_set.add(parallel_value)
            new_set.add(series_value)
      self.values[n] = new_set
      tock = time.time()
      print 'n = ', n, ' elapsed time = ', tock - tick
      tick = tock

  def print_values(self):
    for n in sorted(self.values):
      print repr(n) + ':',
      for value in sorted(self.values[n]):
        print str(value) + "\t",
      print

  def total_count(self):
    all_values = set()
    for n, values in self.values.iteritems():
      all_values = all_values | values
    return len(all_values)

agent = Agent(18)

print agent.total_count()
# print agent.values
# agent.print_values()