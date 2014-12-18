product = 1.0
(0..19).each do |diff|
  product *= (60.0 - diff) / (70 - diff)
end

puts 7.0 * (1 - product) # 6.818741802