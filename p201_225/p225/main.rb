require 'set'

def divisible(limit, mod)
  visited = Set.new
  state = [1, 1, 1]
  limit.times do
    visited << state
    new_number = state.inject(:+) % mod
    # p new_number
    if new_number == 0
      return true
    end
    state = state[1..2] + [new_number]
    if visited.include?(state)
      return false
    end
  end
  false
end

limit = 1500
iteration_limit = 10 ** 6
count = 1
(1..limit).each do |k|
  n = 2 * k + 1
  if !divisible(iteration_limit, n)
    puts "#{count}: #{n}"
    count += 1
    break if count == 125
  end
end
