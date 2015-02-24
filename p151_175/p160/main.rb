require 'benchmark'
require '../../common'

def brute_force(n, digit_count)
  factorial = n.factorial

  while factorial % 10 == 0
    factorial /= 10
  end

  factorial % (10 ** digit_count)
end

def factorial_last_digits(n, digit_count)
  power_2 = 0
  power_5 = 0
  other_last_digits = 1
  mod = 10 ** digit_count
  (2..n).each do |k|
    puts k if k % (10 ** 7) == 0
    while k % 2 == 0
      power_2 += 1
      k /= 2
    end

    while k % 5 == 0
      power_5 += 1
      k /= 5
    end

    other_last_digits = (other_last_digits * k) % mod
  end

  raise if power_2 < power_5
  factor_2 = 2.mod_pow(power_2 - power_5, mod)
  (other_last_digits * factor_2) % mod
end

def main
  n = (10 ** 6)
  p factorial_last_digits(n, 5)
end

puts Benchmark.measure { main }

# 38144 for 10 ** 9
# 