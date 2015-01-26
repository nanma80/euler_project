def fibonaccis(limit)
  output = [1, 2]
  (limit - 2).times do
    output << output[-2] + output[-1]
  end
  output
end

def to_fibonacci_base(n)
  fibo_limit = 100
  fibos = fibonaccis(fibo_limit)
  if n > fibos[-1] + fibos[-2]
    raise "#{n} is too large. Consider increase fibo_limit"
  end

  output = []
  changing_n = n
  fibos.reverse.each do |fibo|
    next if fibo > n
    if changing_n >= fibo
      output << 1
      changing_n -= fibo
    else
      output << 0
    end
  end
  output.reverse
end

def digit_count_brute_force(exclusive_limit)
  count = 0
  (1..exclusive_limit - 1).each do |n|
    # puts n if n % (10 ** 5) == 1
    fibonacci_base = to_fibonacci_base(n)
    count += fibonacci_base.inject(:+)
    p [n, fibonacci_base]
  end
  count
end

# p digit_count_brute_force(10 ** 6) # 7894453
p digit_count_brute_force(5)
