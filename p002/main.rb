limit = 4_000_000
# limit = 50
fib = [0, 1]
sum = 0

while (new_fib = fib[0] + fib[1]) <= limit
  if new_fib % 2 == 0
    sum += new_fib
  end
  fib << new_fib
  fib.shift
end

puts sum # 4613732