def min_n(red_length, size, threshold)
  after_red = [0]
  after_black = [1]

  (1..size).each do |k|
    after_black << (after_black[k - 1] + after_red[k - 1])

    new_after_red = 0
    (0..(k - red_length)).each do |sub_k|
      new_after_red += after_black[sub_k]
    end
    after_red << new_after_red

    if after_black.last + after_red.last > threshold
      return k
    end
  end
  puts "not there yet"
  after_red[size] + after_black[size]
end

p min_n(50, 1000, 10**6)