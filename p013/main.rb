def each_number
  filename = '.\p013\numbers.txt'
  File.open(filename).each do |line|
    yield line.chomp.to_i
  end
end

sum = 0
each_number do |i|
  sum += i
end

puts sum.to_s[0..9]