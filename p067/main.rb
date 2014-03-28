require File.expand_path('../../p018/triangle', __FILE__)

triangle = Triangle.new(File.expand_path('../triangle.txt', __FILE__))
p triangle.max_sum
