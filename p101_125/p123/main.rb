require '../../common'

target = 10 ** 10
primes = Prime::Cache.new(10 ** 7).primes

primes.each_with_index do |prime, index|
  n = index + 1
  next if n % 2 == 0 # r = 2
  r = 2 * n * prime
  if r > target
    puts n
    break
  end
end