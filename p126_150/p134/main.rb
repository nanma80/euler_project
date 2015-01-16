require '../../common'

def process_pair(p1, p2)
  digit_count = p1.to_s.length

  current = p2
  (1..digit_count).each do |matching_digit|
    mod = 10 ** matching_digit
    target = p1 % mod
    step = p2 * 10 ** (matching_digit - 1)
    until current % mod == target
      current += step
    end
  end

  current
end

def main
  prime_limit = 10 ** 6
  limit = (prime_limit * 1.1).to_i
  primes = Prime::Cache.new(limit).primes
  sum = 0
  primes.each_with_index do |p1, index1|
    next if p1 < 5
    break if p1 > prime_limit
    p2 = primes[index1 + 1]
    n = process_pair(p1, p2)
    sum += n
  end

  p sum
end

main
