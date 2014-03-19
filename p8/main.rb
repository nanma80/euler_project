def load_number
  output = ''
  File.open('./p8/input.txt', 'r').each do |line|
    output << line.chomp
  end
  output
end

def each_substring(string, window_size)
  # assuming string is longer than window_size
  substring = string[0..(window_size - 1)]
  yield substring
  string[window_size..-1].split('').each do |character|
    substring = substring[1..-1]
    substring << character
    yield substring
  end
end

def each_product(string, window_size)
  each_substring(string, window_size) do |substring|
    product = 1
    substring.split('').each do |character|
      product *= character.to_i
    end
    yield product
  end
end

# each_substring('string', 3) do |substring|
#   puts substring
# end

max_product = 1
each_product(load_number, 5) do |product|
  max_product = product if product > max_product
end

p max_product # 40824
