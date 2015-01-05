require 'set'

# From p103
def special_sum(array)
  front_sum = array[0]
  end_sum = 0
  front_pointer = 1
  end_pointer = array.length - 1
  while front_pointer < end_pointer
    front_sum += array[front_pointer]
    end_sum += array[end_pointer]
    return false if front_sum <= end_sum
    front_pointer += 1
    end_pointer -= 1
  end

  sums = Set.new
  (1..(2 ** array.length - 1)).each do |gen|
    weights = (gen + 2 ** array.length).to_s(2)[1..-1].split('').map(&:to_i)
    sum = [array, weights].transpose.map{|pair| pair.inject(:*)}.inject(:+)
    return false if sums.include?(sum)
    sums << sum
  end
  true
end

def check(array)
  special_sum(array.sort)
end

sum = 0
filename = 'p105_sets.txt'
File.open(filename).each_line do |line|
  array = line.chomp.split(',').map(&:to_i)
  if check(array)
    sum += array.inject(:+)
  end
end

p sum