generation_limit = 15
target = 200

min_steps = []
min_steps[0] = 0
min_steps[1] = 0

generations = []
generations << [ [1] ]

(1..generation_limit).each do |generation|
  current_gen = []
  last_gen = generations.last
  last_gen.each do |save|
    highest = save.last
    (0..save.length - 1).each do |index|
      sum = highest + save[index]
      if min_steps[sum].nil? || min_steps[sum] > generation
        min_steps[sum] = generation
      end
      current_gen << save + [sum]
    end
  end
  generations << current_gen

  all_set = true
  (1..target).each do |to_check|
    if min_steps[to_check].nil?
      all_set = false
      break
    end
  end
  if all_set
    puts 'Finished'
    break
  end
end

p min_steps[1..target]
p min_steps[1..target].inject(:+)
