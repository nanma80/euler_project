require File.expand_path('../triangle', __FILE__)

# triangle = Triangle.new(File.expand_path('../test_data.txt', __FILE__))
# p triangle.max_sum

triangle = Triangle.new(File.expand_path('../data.txt', __FILE__))
p triangle.max_sum
