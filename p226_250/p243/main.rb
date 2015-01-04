class Integer
  def factors
    n = self
    factors = []
    factor = 2
    while n > 1
      if n % factor == 0
        n = n / factor
        factors << factor
      else
        factor += 1
      end
    end
    factors
  end
end

def phi(n)
  output = n
  n.factors.uniq.each do |prime|
    output = output * (prime - 1)/prime
  end
  output
end

def ratio(n)
  1.0 * phi(n) / (n - 1)
end

target_ratio = 1.0 * 15499 / 94744
puts "target ratio: \n#{target_ratio}"

guess = 2 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23 * 2 * 2
ratio = ratio(guess)
p ratio

if ratio < target_ratio
  puts "found! #{guess}"
end
