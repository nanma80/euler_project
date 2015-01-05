require 'set'

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

def each_array(length, min, max)
  if length == 0
    yield []
    return
  end

  if min > max
    return
  end

  (min..max).each do |first_element|
    each_array(length - 1, first_element + 1, max) do |sub_array|
      yield [first_element] + sub_array
    end
  end
end

n = 7
lower_limit = 11
upper_limit = 50
min_sum = nil
min_sum_array = nil
count = 0
each_array(n, lower_limit, upper_limit) do |array|
  count += 1
  print "#{array}\r" if count % 1000 == 0
  next if array[0] + array[1] < array.last
  if special_sum(array)
    sum = array.inject(:+)
    if min_sum.nil? || min_sum > sum
      min_sum = sum
      min_sum_array = array
      p min_sum_array
    end
  end
end
puts 
puts "Minimum:"
p min_sum
p min_sum_array
puts min_sum_array.map(&:to_s).join

