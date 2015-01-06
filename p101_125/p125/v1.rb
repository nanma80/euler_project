class Integer
  def palindromic?
    str = self.to_s
    str == str.reverse
  end
end

limit = 10 ** 8
squares = (1..Math.sqrt(limit)).to_a.map {|n| n * n}
length = squares.length

good = []

(0..(length - 1)).each do |start_index|
  sum = squares[start_index]
  (start_index + 1..length - 1).each do |end_index|
    sum += squares[end_index]
    break if sum >= limit
    if sum < limit && sum.palindromic?
      good << sum
      p [sum, start_index + 1, end_index + 1, end_index - start_index + 1]
    end
  end
end
good.uniq!
p good
p good.length
p good.inject(:+)