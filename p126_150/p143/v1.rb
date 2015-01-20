def main
  # limit = 2000
  limit = 12000

  sums = []
  puts "Limit of p: #{limit / 3}"
  (1..limit/3).each do |p|
    # puts "#{p}"
    (p..(limit - p)/2).each do |q|
      b_sq = p * p + q * q + p * q
      if (Math.sqrt(b_sq) + 0.5).to_i ** 2 != b_sq
        next
      end
      (q..(limit - p - q)).each do |r|
        a_sq = q * q + r * r + q * r
        if (Math.sqrt(a_sq) + 0.5).to_i ** 2 != a_sq
          next
        end
        c_sq = p * p + r * r + p * r
        if (Math.sqrt(c_sq) + 0.5).to_i ** 2 != c_sq
          next
        end

        a = (Math.sqrt(a_sq) + 0.5).to_i
        b = (Math.sqrt(b_sq) + 0.5).to_i
        c = (Math.sqrt(c_sq) + 0.5).to_i

        puts "#{p}, #{q}, #{r}, #{a}, #{b}, #{c}"
        sums << p + q + r
      end
    end
  end

  p sums.uniq.sort.inject(:+)
end

main