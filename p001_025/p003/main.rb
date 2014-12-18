limit = 10 ** 6
factors = []
n = 600851475143

for i in 2..limit
  if n % i == 0
    puts "Found factor #{i}"
    while n % i == 0
      factors << i
      n = n / i
    end
  end
end

p factors
puts factors.inject(1) {|product, n| product * n} # to verify if we've found all factors

# 6857