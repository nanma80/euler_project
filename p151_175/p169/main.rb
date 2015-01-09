require 'set'

def binary_array(number, length = nil)
  array = number.to_s(2).split('').map(&:to_i)
  unless length.nil?
    array = [0] * (length - array.length) + array
  end
  array
end

def count_v1(number)
  representations = Set.new

  original_array = binary_array(number)
  original_length = original_array.length

  (0..number-1).each do |sub|
    difference_array = binary_array(number - sub, original_length)
    sub_array = binary_array(sub, original_length)

    representations << [difference_array, sub_array].transpose.map do |array|
      array[0] + array[1]
    end
  end
  
  representations.length
end

def count_v2(number)
  original_array = binary_array(number)
  
  representations = Set.new
  process_queue = Set.new([original_array])

  counter = 0
  until process_queue.empty?
    counter += 1
    p process_queue.length if counter % 1000 == 0
    seed = process_queue.first
    process_queue.delete(seed)

    representations << seed
    variations(seed).each do |variation|
      if !(representations.include?(variation) || process_queue.include?(variation))
        process_queue << variation
      end
    end
  end
  representations.length
end

def variations(array)
  variations = []
  length = array.length
  array.each_with_index do |elem, index|
    next if elem == 0
    next if index == length - 1
    next if array[index + 1] != 0

    dup = array.dup
    dup[index] = dup[index] - 1
    dup[index + 1] += 2

    variations << dup
  end
  variations
end

def count(number)
  number_string = number.to_s(2)
  initialized = false
  g = nil # count representations with the same number of digits as regular binary expansion
  h = nil # count representations with one less digit than regular binary expansion
  f = nil # g + h. Total count
  zero_count = 0 # number of zeros after the first 1
  number_string.split('').reverse.each do |char|
    digit = char.to_i
    if not initialized
      g = 1
      h = 0
      f = g + h
      initialized = true
    elsif digit == 1
      g = f
      h = zero_count * f + h
      f = g + h
    end

    if digit == 0
      zero_count += 1
    else
      zero_count = 0
    end
  end
  f
end

n = 10 ** 25

p count(n)

