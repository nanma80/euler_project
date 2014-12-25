require './p367'

def steps_avg(steps)
  step_sum = 0
  total_weight = 0

  steps.each do |orbit_array, step|
    weight = Orbit.new(orbit_array).weight
    total_weight += weight
    step_sum += step * weight
  end
  1.0 * step_sum / total_weight
end

size = 11
num_iterations = 10000
initial_value = 48271207 # this is the final answer

all_orbits = Orbit.all(size)
original_orbit = Orbit.new([1] * size)
steps = {}

initial_value_for_others = 1.0 * initial_value * size.factorial / (size.factorial - 1)
all_orbits.each do |orbit|
  steps[orbit.to_a] = initial_value_for_others
end
steps[original_orbit.to_a] = 0

num_iterations.times do |iteration|
  new_steps = {}
  
  all_orbits.each do |orbit|
    if orbit == original_orbit
      new_steps[orbit.to_a] = 0
    else
      step = 1
      neighbors = orbit.neighbors
      total_weight = neighbors.values.inject(:+)
      neighbors.each do |neighbor_array, weights|
        step += 1.0 * (steps[neighbor_array] || 0) * weights / total_weight
      end
      new_steps[orbit.to_a] = step
    end
  end
  steps = new_steps
  if iteration % 100 == 0
    puts "#{iteration}: #{steps_avg(steps)}"
  end
end

p steps
puts "Final: #{steps_avg(steps)}"