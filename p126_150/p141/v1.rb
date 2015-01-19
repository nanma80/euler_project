limit = 10 ** 7

sum = 0
(1..Math.sqrt(limit)).each do |a|
  (a+1..limit).each do |c|
    break if Math.sqrt(a * c) * c + a >= limit

    b_sq = a * c
    b = (Math.sqrt(b_sq) + 0.5).to_i
    if b * b == b_sq
      n = b * c + a
      if (Math.sqrt(n) + 0.5).to_i ** 2 == n && n < limit
        p [n, a, b, c]
        sum += n
      end
    end
  end
end

puts "Sum: #{sum}"
