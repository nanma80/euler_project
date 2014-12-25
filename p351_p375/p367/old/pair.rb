require 'pp'

def neighbors(state)
  output = []
  state.length.times do |i|
    state.length.times do |j|
      break if j >= i
      new_state = state.dup
      new_state[i], new_state[j] = new_state[j], new_state[i]
      output << new_state
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

steps = {}
original_state = (1..4).to_a
states = original_state.permutation.to_a
steps[original_state] = 0
num_iterations = 500

num_iterations.times do |iteration|
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
end

p steps_avg(steps)
pp steps
