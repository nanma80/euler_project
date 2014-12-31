require './p084'

dice = Dice.new(4)
monopoly = Monopoly.new
transition_matrix = monopoly.transition_matrix(dice)
vector = [1.0 / monopoly.board_size] * monopoly.board_size

100.times do
  new_vector = transition_matrix.map do |row|
    sum = 0.0
    row.each_with_index do |cell, i|
      sum += cell * vector[i]
    end
    sum
  end
  vector = new_vector
end

prob = []
vector.each_with_index do |value, position|
  prob << [value, position]
end

sorted_prob = prob.sort_by do |value, position|
  - value
end

puts sorted_prob[0..2].map {|a| "%.2d" % a.last}.join