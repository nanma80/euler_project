limit = 10**5
largest = 0

(1..limit).each do |a|
  string = a.to_s
  multiple = 1
  while string.length < 9
    multiple += 1
    string << (a * multiple).to_s
  end
  next if string.length != 9
  next if string.include? '0'
  next if string.split('').uniq.length != 9
  pandigit = string.to_i
  p [a, multiple, pandigit]
  if pandigit > largest
    largest = pandigit
  end
end

p largest