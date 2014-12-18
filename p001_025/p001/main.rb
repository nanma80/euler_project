n = 1000
sum = 0

(1..n-1).to_a.each do |k|
  if k % 3 == 0 || k % 5 == 0
    sum += k
  end
end

puts sum # 233168
