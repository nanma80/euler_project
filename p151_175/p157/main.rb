# b = (a 10^n)/(ap - 10^n)

def count(n)
  count = 0
  power_10 = 10 ** n
  (1..(2 * power_10)).each do |a|
    puts "#{100 * a/(2 * power_10)}%" if a % (10 ** 7) == 0
    ((power_10/a + 1)..(2 * power_10/a)).each do |pp|
      b_denominator = a * pp - power_10
      next if (a * power_10) % b_denominator != 0
      b = (a * power_10) / b_denominator
      count += 1
      # p [a, b, pp]
    end
  end
  count
end

total = 0
(1..6).each do |n|
  count = count(n)
  p [n, count]
  total += count
end
p total
