def is_prime?(i, primes)
  is_prime = true
  primes.each do |prime|
    if i % prime == 0
      is_prime = false
      break
    end
  end
  is_prime
end

def primes(count)
  primes = [2]
  i = 2

  while primes.length < count
    i += 1
    if is_prime?(i, primes)
      primes << i
      puts (primes.length).to_s + "\t" + i.to_s if primes.length % 1000 == 0
    end
  end
  primes
end

p primes(10001).last # 104743
