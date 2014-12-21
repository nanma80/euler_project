def same_chars(array)
  return false if array.length <= 1

  chars = array[0].to_s.split('').sort
  (1..(array.length-1)).each do |i|
    if not (array[i].to_s.split('').sort == chars)
      return false
    end
  end
  true
end

limit = 10 ** 6
(1..limit).each do |n|
  if same_chars([n, 2 * n, 3 * n, 4 * n, 5 * n, 6 * n])
    p n
    exit
  end
end

