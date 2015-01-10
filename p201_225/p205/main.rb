def dice_prob(side_count, dice_count)
  prob = {}
  power = side_count ** dice_count
  (0..(power - 1)).each do |generator|
    values = (generator + power).to_s(side_count)[1..-1].split('').map do |char|
      char.to_i + 1
    end
    total = values.inject(:+)
    prob[total] = (prob[total] || 0) + 1.0/power
  end
  prob.sort
end

player1 = dice_prob(4, 9)
player2 = dice_prob(6, 6)

total_prob = 0.0

player1.each do |player1_roll|
  value1 = player1_roll[0]
  prob1 = player1_roll[1]
  player2.each do |player2_roll|
    value2 = player2_roll[0]
    break if value2 >= value1
    prob2 = player2_roll[1]
    p [value1, value2]
    total_prob += prob1 * prob2
  end
end

p total_prob
