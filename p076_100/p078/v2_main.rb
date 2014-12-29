require 'pp'
limit = 10 ** 6
target = 10 ** 6

cache = [[1]] # cache[0][0] == 1

(1..limit).each do |sum|
  cache[sum] = [0]
  count = 0
  (1..sum).each do |max|
    count += cache[sum - max][[sum - max, max].min]
    count = count % target
    cache[sum][max] = count
  end

  puts "#{sum}\t#{cache[sum][sum]}"
  if cache[sum][sum] == 0
    puts "Found: #{sum}"
    exit
  end
end
