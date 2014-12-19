sum = 0

(1..1000).each do |n|
  sum += (n ** n)
end

puts sum.to_s[-10..-1]