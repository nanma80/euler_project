require 'set'

class Chain
  attr_reader :arrive_at_89

  def initialize(limit)
    @arrive_at_89 = [nil] * (limit + 1)
    @arrive_at_89[89] = true
    @arrive_at_89[1] = false
  end

  def square_digit(n)
    n.to_s.split('').map do |digit_char|
      (digit_char.to_i) ** 2
    end.inject(:+)
  end

  def end_with_89(n)
    path = []
    while @arrive_at_89[n].nil?
      path << n
      n = square_digit(n)
    end

    arrived_at_89 = @arrive_at_89[n]
    
    path.each do |i|
      @arrive_at_89[i] = arrived_at_89
    end
    arrived_at_89
  end
end

limit = 10 ** 7 - 1

chain = Chain.new(limit)
count = 0
(1..limit).each do |n|
  puts n if n % (10 ** 5) == 0
  if chain.end_with_89(n)
    count += 1
  end
end

p count
# 8581146 Very slow
