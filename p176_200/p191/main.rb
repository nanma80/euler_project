def empty_count
  # first row: no L. second row: one L
  # first column: last day not A
  # second column: last day A but the day before not
  # third column: last two days A but the day before not
  [
    [0, 0, 0],
    [0, 0, 0]
  ]
end

def initial_count
  count = empty_count
  count[0][0] = 1
  count
end

def next_count(old_count)
  new_count = empty_count
  new_count[0][0] += old_count[0].inject(:+) # +O
  new_count[1][0] += old_count[1].inject(:+) # +O
  
  new_count[1][0] += old_count[0].inject(:+) # +L

  new_count[0][1] += old_count[0][0] # +A
  new_count[1][1] += old_count[1][0] # +A

  new_count[0][2] += old_count[0][1] # +A
  new_count[1][2] += old_count[1][1] # +A
  new_count
end

def total(count)
  count.map do |row|
    row.inject(:+)
  end.inject(:+)
end

day_count = 30

count = initial_count
day_count.times do
  count = next_count(count)
end

p total(count)