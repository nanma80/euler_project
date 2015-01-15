require '../../common'

def remainders(high)
  output = {}
  primes = Prime::Cache.new(high).primes
  primes.each do |prime|
    if prime != 2 && prime != 5
      output[prime] = 1
    end
  end
  output
end

def main
  prime_limit = 4 * (10 ** 5)
  limit = 10 ** 9
  primes = Prime::Cache.new(prime_limit).primes

  factors = []
  primes.each do |prime|
    if prime != 2 && prime != 5
      if 10.mod_pow(limit, prime * 9) == 1
        factors << prime
      end
    end
  end

  factors.sort!

  p factors
  p factors.length
  p factors[0..39].inject(:+)
end

start_time = Time.new
main
puts "Time: #{Time.new - start_time} seconds"