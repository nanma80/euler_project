require 'pp'

class Integer
  def palindromic?
    str = self.to_s
    str == str.reverse
  end
end

limit = 10 ** 8
length = Math.sqrt(limit)

numbers = []
# details = []

(1..length).each do |start_number|
  sum = start_number * start_number
  (start_number + 1..length).each do |end_number|
    sum += end_number * end_number
    break if sum >= limit
    if sum < limit && sum.palindromic?
      numbers << sum
      # details << [sum, start_number, end_number, end_number - start_number + 1]
    end
  end
end

numbers = numbers.uniq
numbers.sort!
# details.sort!

# p numbers
# pp details

p numbers.length
p numbers.inject(:+)

