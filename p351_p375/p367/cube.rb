def neighbors(state)
  output = []
  state_array = state.split('').map(&:to_i)
  state_array.length.times do |index|
    new_state = state_array.dup
    new_state[index] = new_state[index] ^ 1
    output << new_state.map(&:to_s).join
  end
  output
end

steps = {}
steps['000'] = 0
states = (0..7).to_a.map {|n| (n + 8).to_s(2)[1..-1]}
p states


100.times do |iteration|
  new_steps = {}
  new_steps['000'] = 0
  states.each do |state|
    if state == '000'
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

p steps