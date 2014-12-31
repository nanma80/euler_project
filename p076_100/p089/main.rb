require './p089'

filename = 'p089_roman.txt'

conv = Conv.new

sum = 0

input_romans = File.read(filename).split("\n")
input_romans.each do |input_roman|
  int = conv.to_int(input_roman)
  output_roman = conv.to_roman(int)
  input_length = input_roman.length
  output_length = output_roman.length

  sum += input_length - output_length
end

p sum
