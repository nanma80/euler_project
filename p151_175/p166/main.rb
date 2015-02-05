base = 10
limit = base ** 8
count = 0
(limit..(2 * limit - 1)).each do |generator|
  if generator % 100000 == 0
    puts "#{100.0 * (generator - limit)/limit}%"
  end
  list = generator.to_s(base)[1..-1].split('').map(&:to_i)
  x00 = list[0]
  x01 = list[1]
  x02 = list[2] 
  x03 = list[3]
  x10 = list[4]
  x11 = list[5]
  x12 = list[6]
  x20 = list[7]
  new_variable = x00 + x01 + x02 + x03 - x10 - x11 - x12
  next unless new_variable >= 0 && new_variable <= 9
  
  new_variable = x00 - x03 + x10 - x12 + x20
  next unless new_variable >= 0 && new_variable <= 9

  new_variable = x01 + x02 + 2*x03 - x10 - x11 - x20
  next unless new_variable >= 0 && new_variable <= 9

  new_variable = x11 + x12 - x20
  next unless new_variable >= 0 && new_variable <= 9

  new_variable = x01 + x02 + x03 - x10 - x20
  next unless new_variable >= 0 && new_variable <= 9

  new_variable = x02 + 2*x03 - x10 - x11 + x12 - x20
  next unless new_variable >= 0 && new_variable <= 9

  new_variable = x00 - x02 - x03 + x10 + x11 - x12 + x20
  next unless new_variable >= 0 && new_variable <= 9

  new_variable = -x03 + x10 + x20
  next unless new_variable >= 0 && new_variable <= 9

  count += 1
end
p count