require 'csv'
require File.expand_path('../string', __FILE__)

names_file = File.expand_path('../names.txt', __FILE__)

names = []

CSV.foreach(names_file) do |row|
  names = row
end

names.sort!

sum = 0

names.each_with_index do |name, index|
  sum += name.score * (index + 1)
end

p sum
