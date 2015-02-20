import time

class DigitCounter:
  def __init__(self, limit):
    self.limit = limit
    self.counts = [0] * 10
    self.sum_of_solutions = 0

  def get_sum(self):
    solution_counter = 1
    for i in xrange(0, (self.limit + 1)):
      for ch in list(str(i)):
        digit = (int)(ch)
        self.counts[digit] += 1

      is_solution = False
      for digit in xrange(1, 10):
        if self.counts[digit] == i:
          print solution_counter, i, digit
          self.sum_of_solutions += i
          is_solution = True

      if is_solution:
        solution_counter += 1

    return self.sum_of_solutions

def main():
  start_time = time.time()
  limit = 10 ** 6
  digit_counter = DigitCounter(limit)
  print digit_counter.get_sum()
  end_time = time.time()
  print end_time - start_time

if __name__ == '__main__':
  main()