require 'benchmark'

def powers_2_5(n)
  unless n > 0
    return [0, 0]
  end

  powers = []
  [2, 5].each do |factor|
    power = 0
    while n % factor == 0
      power += 1
      n /= factor
    end
    powers << power
  end
  powers
end

def factorials_powers_2_5(limit)
  last_powers = [0, 0]
  factorials = [last_powers.dup]
  
  (1..limit).each do |n|
    new_powers = powers_2_5(n)
    [0, 1].each do |index|
      last_powers[index] += new_powers[index]
    end
    factorials << last_powers.dup
  end
  factorials
end

def symmetry_count(n, threshold, factorials)
  count = 0
  (0..n).each do |i|
    puts i if i % 100 == 0
    (0..(n - i)).each do |j|
      break if j > i
      k = n - i - j
      next if k > j

      powers = factorials[n].dup
      [i, j, k].each do |den|
        [0, 1].each do |index|
          powers[index] -= factorials[den][index]
        end
      end
      next if powers[0] < threshold || powers[1] < threshold

      if i == j && j == k
        count += 1
      elsif i == j || j == k
        count += 3
      else
        count += 6
      end
    end
  end
  count
end

def main
  limit = 2 * (10 ** 3)
  # limit = 200
  threshold = 12
  factorials = factorials_powers_2_5(limit)
  p symmetry_count(limit, threshold, factorials)
end


puts Benchmark.measure { main }
