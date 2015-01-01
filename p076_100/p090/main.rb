require './cubes'

(0..(2 ** 8 - 1)).each do |code|
  cubes = Cubes.new(code)
  # next if cubes.cube_lengths.max > 6
  p cubes.cube_lengths# + cubes.cubes
end