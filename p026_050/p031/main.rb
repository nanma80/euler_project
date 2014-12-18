require 'set'

types = [1, 2, 5, 10, 20, 50, 100, 200]

ways = {}

ways[0] = Set.new
ways[0].add([0] * types.length)

LIMIT = 200

(1..LIMIT).each do |value|
  set = Set.new
  types.each_with_index do |type, index|
    base = value - type
    next if base < 0
    ways[base].each do |plan|
      new_plan = plan.dup
      new_plan[index] += 1
      set.add(new_plan)
    end
  end
  ways[value] = set
end

puts ways[LIMIT].length # 73682