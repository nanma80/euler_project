limit = 10 ** 4

billion_f = -1 * (10 ** 9)
exp = 30.403243784
visited = {}

(1..limit).each do |index|
  x = billion_f * (0.1 ** 9)
  billion_f = (2 ** (exp - x * x)).to_i
  if visited[billion_f].nil?
    visited[billion_f] = index
  else
    loop_length = index - visited[billion_f]
    puts "Loop length: #{loop_length}"
    break
  end
end

# Found a length two cycle
sum = 0.0
x = billion_f * (0.1 ** 9)
sum += x

billion_f = (2 ** (exp - x * x)).to_i
x = billion_f * (0.1 ** 9)
sum += x
p sum

