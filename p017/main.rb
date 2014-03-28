require File.expand_path('../english_number', __FILE__)

sum = 0
(1..1000).each do |number|
  sum += EnglishNumber.new(number).letter_count
end

puts sum