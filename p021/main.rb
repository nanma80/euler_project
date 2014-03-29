require File.expand_path('../integer', __FILE__)

sum = 0

(1..9999).each do |n|
  if n.is_amicable?
    sum += n
  end
end

puts sum
