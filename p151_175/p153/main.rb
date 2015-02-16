require 'benchmark'

def gcd(a, b)
  return gcd(b, a) if a < b
  return a if b == 0
  gcd(b, a % b)
end

def sum_real_divisors(limit)
  sum = 0
  (1..limit).each do |k|
    puts k if k % (10 ** 6) == 0
    sum += (limit / k) * k
  end
  sum
end

def sum_complex_divisors(limit)
  sum = 0
  alpha_limit = Math.sqrt(limit).to_i
  (1..alpha_limit).each do |alpha|
    puts alpha if alpha % (10 ** 3) == 0
    (1..alpha).each do |beta|
      sqrt_sum = alpha * alpha + beta * beta
      break if sqrt_sum > limit
      next unless gcd(alpha, beta) == 1
      
      (1..(limit / sqrt_sum)).each do |gamma|
        base_n = sqrt_sum * gamma
        sum += (limit / base_n) * (2 * alpha * gamma)
        if beta < alpha
          sum += (limit / base_n) * (2 * beta * gamma)
        end
      end
    end
  end
  sum
end

def main
  limit = 10 ** 5

  real = sum_real_divisors(limit)
  complex = sum_complex_divisors(limit)
  
  p real + complex
end

puts Benchmark.measure { main }
