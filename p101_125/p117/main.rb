def count(length, sizes)
  cache = [0] * (length + 1)
  cache[0] = 1
  (1..length).each do |current_length|
    count_for_k = 0
    sizes.each do |size|
      sub = current_length - size
      if sub >= 0
        count_for_k += cache[sub]
      end
    end
    cache[current_length] = count_for_k
  end
  cache.last
end

p count(50, [1, 2, 3, 4])