require './cubes'
require 'set'

def expand(array)
  output = []
  if array.length == 6
    output << array
  elsif array.length == 5
    (0..9).each do |to_add|
      next if array.include?(to_add) # Do we need it?
      output << (array.dup + [to_add]).sort
    end
  elsif array.length == 4
    (0..9).each do |to_add_1|
      next if array.include?(to_add_1) # Do we need it?
      (0..(to_add_1 - 1)).each do |to_add_2|
        next if array.include?(to_add_2) # Do we need it?
        output << (array.dup + [to_add_1, to_add_2]).sort
      end
    end
  else
    raise "Unhandled case #{array.inspect}"
  end
  output
end

def all_compatible(array)
  output = []
  output << array.dup
  if array.include?(6)
    new_array = array.dup
    new_array.delete(6)
    new_array << 9
    output << new_array
  end
  
  expanded_output = []
  output.each do |output_array|
    expanded_output += expand(output_array)
  end
  expanded_output.uniq
end

cubes = Cubes.new(13)

search_range = (2 ** 8 - 1) # Always assign "01" in the same way

arrangements = Set.new

(0..search_range).each do |code|
  cubes = Cubes.new(code)
  next if cubes.cube_lengths.max > 6

  all_compatible(cubes.cubes[0]).each do |cube0|
    all_compatible(cubes.cubes[1]).each do |cube1|
      arrangements << [cube0, cube1].sort
    end
  end
end

puts arrangements.length