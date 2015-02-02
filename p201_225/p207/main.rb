limit = 10 ** 6
target = Rational(1, 12345)
(2..limit).each do |x|
  k = x * (x - 1)
  total_count = x - 1
  perfect_count = Math.log2(x).to_i
  ratio = Rational(perfect_count, total_count)
  if ratio < target
    puts "m: #{k}, ratio: #{ratio}"
    break
  end
end