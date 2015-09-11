# http://www.mathpuzzle.com/bdalytriangles.html
def total(n)
  (1678 * n * n * n + 3117 * n * n + 88 * n - 345*(n % 2) - 320*(n % 3) - 90*(n % 4) - 288*((n * n * n - n* n+ n) % 5)) / 240
end

puts total(36)