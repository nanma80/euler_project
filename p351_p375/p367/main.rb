def neighbors(state)
  output = []
  state.length.times do |i|
    state.length.times do |j|
      break if j >= i
      state.length.times do |k|
        break if k >= j
        [i, j, k].permutation do |perm|
          new_state = state.dup
          new_state[i], new_state[j], new_state[k] = new_state[perm[0]], new_state[perm[1]], new_state[perm[2]]
          output << new_state
        end
      end
    end
  end
  output
end

def steps_avg(steps)
  step_sum = 0
  steps.each do |state, step|
    step_sum += step
  end
  step_sum / steps.length
end

original_state = (1..11).to_a
states = []
original_state.permutation do |perm|
  states << perm
end

puts "Number of states: #{states.length}"

steps = {}
states.each do |state|
  steps[state] = 10.0
end
steps[original_state] = 0

num_iterations = 200


num_iterations.times do |iteration|
  puts "Starting interation #{iteration}"
  new_steps = {}
  new_steps[original_state] = 0
  states.each do |state|
    if state == original_state
      new_steps[state] = 0
    else
      neighbors = neighbors(state)
      step = 1
      neighbors.each do |neighbor|
        step += 1.0 * (steps[neighbor] || 0) / neighbors.length
      end
      new_steps[state] = step
    end
  end
  steps = new_steps
  puts "#{iteration}: #{steps_avg(steps)}"
end

# p steps
