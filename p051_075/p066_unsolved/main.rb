class Integer
  def is_square?
    Math.sqrt(self).to_i ** 2 == self
  end
end

def max_d(candidates = nil, max_x = 10 ** 6)
  range = 1_000
  candidates = candidates || (1..range).to_a
  candidates = candidates.select do |d|
    not d.is_square?
  end

  (2..max_x).each do |x|
    candidates = candidates.select do |d|
      not ((x * x - 1) % d == 0 && ((x * x - 1)/d).is_square?)
    end
    p [x, candidates]
    if candidates.length <= 1
      return candidates.first
    end
  end
end

p max_d

# limit_d = 1000
# max_x = 0
# max_d = 0

# (110..limit_d).each do |d|
#   next if [61, 109].include? d
#   x = min_solution(d)
#   next if x.nil?
#   p [d, x]
#   if x > max_x
#     max_x = x
#     max_d = d
#   end
# end
# p max_d


# p min_solution(61)