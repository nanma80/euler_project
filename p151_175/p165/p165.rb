require 'set'
require './lib/point'
require './lib/line'

line_count = 5000

intersections = Set.new
lines = Line.generate(line_count)
lines.each_with_index do |line1, index1|
  p index1
  (0..index1 - 1).each do |index2|
    intersection = line1.intersect(lines[index2])
    unless intersection.nil?
      intersections << intersection.coordinates
    end
  end
end

p intersections.length