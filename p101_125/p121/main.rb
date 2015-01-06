require '../../common'

round_count = 15

sum = 0
(0..round_count).each do |red_count|
  break if red_count * 2 >= round_count
  (1..round_count).to_a.combination(red_count) do |combi|
    if combi.empty?
      sum += 1
    else
      sum += combi.inject(:*)
    end
  end
end

p (round_count + 1).factorial / sum

# (1..round_count)