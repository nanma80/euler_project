def term(n, k)
  1.0 - (1.0 - 1.0 /(2 ** (n - 1))) ** k
end

def expectation(k)
  sum = 0
  epsilon = 0.1 ** 18
  (1..1_000).each do |n|
    term = term(n, k)
    break if term < epsilon
    sum += term
  end
  sum
end

p expectation(32)
