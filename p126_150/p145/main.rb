def count_reversable(limit)
  counter = 0
  (1..limit - 1).each do |n|
    puts n if n % (10 ** 5) == 0
    n_string = n.to_s
    next if n_string[-1] == '0'
    next if (n_string[-1].to_i + n_string[0].to_i) % 2 == 0
    reverse_string = n_string.reverse
    reverse = reverse_string.to_i
    sum = reverse + n
    should_skip = false
    sum.to_s.split('').each do |char|
      if (char.to_i % 2) == 0
        should_skip = true
        break
      end
    end
    next if should_skip

    counter += 1
  end
  counter
end

puts
p count_reversable(10 ** 9)
# 608720