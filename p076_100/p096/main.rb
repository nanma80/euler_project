require File.expand_path('../lib/loader', __FILE__)
require File.expand_path('../lib/loader_buffer', __FILE__)

require File.expand_path('../lib/cell', __FILE__)
require File.expand_path('../lib/constraint', __FILE__)
require File.expand_path('../lib/grid', __FILE__)

testing_mode = false

grids = Loader.execute(testing: testing_mode)

solved_count = 0
stuck_count = 0

signature_sum = 0

grids.each do |grid|
  (state, iteration, current_grid) = grid.solve
  puts "Grid #{grid.id}: \t#{state},\tafter #{iteration} iterations"
  if state == 'solved'
    p current_grid
    solved_count += 1
    signature_sum += current_grid.signature
  elsif state == 'stuck'
    stuck_count += 1
    puts grid.snapshot
  end
end

puts "Solved: #{solved_count}. Stuck: #{stuck_count}. Others: #{50 - solved_count - stuck_count}"
puts "Signature sum: #{signature_sum}"
