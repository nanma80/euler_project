require '../../common'

def count(n)
  count = 0
  (1..n).to_a.combination(2) do |comb|
    count += 2 ** (comb[1] - comb[0] - 1)
  end
  count * (26.choose(n))
end

max_count = 0
(0..26).each do |n|
  count = count(n)
  p [n, count]
  if count > max_count
    max_count = count
  end
end

puts "Max: #{max_count}"