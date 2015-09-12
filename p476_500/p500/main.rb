require '../../common'

target = 500500
limit = 10 ** 7
prime_cache = Prime::Cache.new(limit)

prime_powers = prime_cache.prime_check.clone

prime_cache.each_prime do |prime|
  power = prime
  while power <= limit
    prime_powers[power] = true
    power = power * power
  end
end

product = 1
modulo = 500500507

counter = 0
prime_powers.each_with_index do |check, index|
  if check
    counter += 1
    product *= index
    product %= modulo
    if counter == target
      puts 'Found answer'
      p product

      exit(0)
    end
  end
end

puts "limit: #{limit}; counter: #{counter}"
