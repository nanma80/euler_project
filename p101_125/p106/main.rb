def pick(array, length, min_index = 0)
  if length == 0
    yield [], array
    return
  end

  if array.length < length || min_index >= array.length
    return
  end

  (min_index..(array.length - 1)).each do |picked_index|
    new_array = array.dup
    picked_element = new_array.delete_at(picked_index)

    pick(new_array, length - 1, picked_index) do |picked_elements, leftover|
      yield [picked_element] + picked_elements, leftover
    end
  end
end

def need_test(array1, array2)
  if array1.length != array2.length
    return false
  end
  first_comparison = (array1[0] < array2[0])
  (1..array1.length - 1).each do |pointer|
    if (array1[pointer] < array2[pointer]) != first_comparison
      return true
    end
  end
  false
end


n = 12

array = (0..(n - 1)).to_a
count = 0

(2..(n/2)).each do |k|
  pick(array, k) do |picked_1, leftover|
    pick(leftover, k) do |picked_2, leftover2|
      next if picked_1.first > picked_2.first
      count += 1 if need_test(picked_1, picked_2)
    end
  end
end
p count