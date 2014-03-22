def each_triangle_number(count)
  sum = 0
  (1..count).each do |i|
    sum += i
    yield sum
  end
end

def factors(number)
  output = []
  i = 1
  while i * i < number
    if number % i == 0
      output << i
      output << number / i
    end
    i += 1
  end
  output << i if i * i == number
  output
end

each_triangle_number(100_000) do |i|
  if factors(i).length > 500
    p i
    exit
  end
end

