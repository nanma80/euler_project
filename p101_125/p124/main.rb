def all_factors(limit)
  all_factors = [[]] * (limit + 1)
  (2..limit).each do |pointer|
    next unless all_factors[pointer].empty?
    all_factors[pointer] = all_factors[pointer] + [pointer]
    set_pointer = pointer + pointer
    while set_pointer <= limit
      all_factors[set_pointer] = all_factors[set_pointer] + [pointer]
      set_pointer += pointer
    end
  end
  all_factors
end

limit = 10 ** 5

all_factors = all_factors(limit)

rad_n = [[0, 0], [0, 1]]

(2..limit).each do |i|
  rad = all_factors[i].inject(:*)
  rad_n << [rad, i]
end

rad_n.sort!

p rad_n[10 ** 4].last
