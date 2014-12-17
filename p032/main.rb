require 'set'
require 'pp'

products = Set.new

(0..100).each do |a|
  (a..10000).each do |b|
    c = a * b
    next if a.to_s.length + b.to_s.length + c.to_s.length != 9
    digits = Set.new
    [a, b, c].each do |number|
      number.to_s.split('').each do |char|
        digits << char.to_i
      end
    end
    digits << 0
    next unless digits.length == 10
    products << c
  end
end

sum = 0
products.each do |product|
  sum += product
end

puts sum