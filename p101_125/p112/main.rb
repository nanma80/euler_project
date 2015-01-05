class Integer
  def bouncy?
    str = self.to_s
    length = str.length
    return false if length < 3
    up = false
    down = false
    (1..length - 1).each do |i|
      if str[i-1] > str[i]
        down = true
      elsif str[i-1] < str[i]
        up = true
      end
      if up && down
        return true
      end
    end
    false
  end
end


not_bouncy_count = 0
multiple = 100
limit = 10 ** 7
(1..limit).each do |n|
  # puts n if n % (10 ** 5) == 0
  not_bouncy_count += 1 unless n.bouncy?
  if not_bouncy_count * multiple == n
    puts n
    break
  end
end

# p [limit, not_bouncy_count]