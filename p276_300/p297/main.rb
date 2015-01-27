def fibonaccis(limit)
  output = [1, 2]
  (limit - 2).times do
    output << output[-2] + output[-1]
  end
  output
end

def fibo_limit
  100
end

def to_fibonacci_base(n)
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
  output
end

def to_i(fibonacci_base_array)
  reversed_array = fibonacci_base_array.reverse
  fibos = fibonaccis(reversed_array.length)
  sum = 0
  reversed_array.each_with_index do |bit, index|
    if bit == 1
      sum += fibos[index]
    end
  end
  sum
end

def digit_count_brute_force(exclusive_limit)
  count = 0
  (0..exclusive_limit - 1).each do |n|
    fibonacci_base = to_fibonacci_base(n)
    count += fibonacci_base.inject(0) { |mem, var| mem + var }
  end
  count
end

def generate_sums
  fibos = fibonaccis(fibo_limit)
  output = [0, 1]
  fibo_limit.times do |index|
    output << fibos[index] + output[-2] + output[-1]
  end
  output
end

def digit_count(exclusive_limit)
  limit_fibo_base = to_fibonacci_base(exclusive_limit)
  sums = generate_sums
  fibos = fibonaccis(fibo_limit)
  length = limit_fibo_base.length
  prefix = 0
  count = 0
  limit_fibo_base.each_with_index do |bit, index|
    digit_worth = length - 1 - index
    if bit == 1
      count += prefix * fibos[digit_worth] + sums[digit_worth]
      prefix += 1
    end
  end
  count
end

def consistent(n)
  digit_count(n) == digit_count_brute_force(n)
end

# p digit_count_brute_force(10 ** 6) # 7894453

# p digit_count(100)

# p digit_count_brute_force(100)
# (1..1000).each do |n|
#   unless consistent(n)
#     p n
#   end
# end

p digit_count(10 ** 17)