require File.expand_path('../integer', __FILE__)

def fibonacci(limit)
  yield 1, 1
  yield 1, 2

  index = 3
  buffer = [1, 1]
  (3..limit).each do |index|
    new_fibo = buffer[0] + buffer[1]
    buffer = [buffer[1], new_fibo]
    yield new_fibo, index
  end
end

fibonacci(10000) do |fibo, index|
  if fibo.n_digits == 1000
    puts index
    exit
  end
end

