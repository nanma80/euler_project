require 'benchmark'
require '../../common'

def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    next unless all_factors[pointer].empty?
    all_factors[pointer] = all_factors[pointer] + [pointer]
    set_pointer = pointer + pointer
    while set_pointer <= limit
      all_factors[set_pointer] = all_factors[set_pointer] + [pointer]
      set_pointer += pointer
    end
  end
  all_factors
end

def phi(n, factors)
  output = n
  factors.each do |prime|
    output = output * (prime - 1)/prime
  end
  output
end

def m(n, all_factors)
  max_so_far = 0
  each_coprime_factorization(n, all_factors[n]) do |u, v|
    phi_v = phi(v, all_factors[v])
    w = u.mod_pow(phi_v - 1, v)
    x = w * u
    if x > max_so_far && x < n
      max_so_far = x
    end
  end
  max_so_far
end

def powered_factors(n, factors)
  powered_factors = []
  changing_n = n
  factors.each do |factor|
    powered_factor = 1
    while changing_n % factor == 0
      changing_n /= factor
      powered_factor *= factor
    end
    powered_factors << powered_factor
  end
  powered_factors
end

def each_coprime_factorization(n, factors)
  powered_factors = powered_factors(n, factors)
  generator_limit = 2 ** powered_factors.length
  generator_limit.times do |generator|
    signature = (generator + generator_limit).to_s(2)[1..-1].split('').map(&:to_i)
    u = 1
    v = 1
    signature.each_with_index do |included, i|
      if included == 1
        u *= powered_factors[i]
      else
        v *= powered_factors[i]
      end
    end
    yield u, v
  end
end

def main
  limit = 10 ** 7
  total = 0
  all_factors = all_factors(limit)
  puts 'Cached factors'
  all_factors.each_with_index do |factors, n|
    puts n if n % (10 ** 4) == 0
    if factors.length == 0
      total += 0
    elsif factors.length == 1
      total += 1
    else
      total += m(n, all_factors)
    end
  end

  p total
end

puts Benchmark.measure { main }