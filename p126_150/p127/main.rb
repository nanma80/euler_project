# http://abcathome.com/algorithm.php
require 'set'

def all_factors(limit)
  all_factors = []
  (limit + 1).times { all_factors << [] }

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

def radicals_hash(all_factors, limit)
  hash = {}
  (1..limit).each do |n|
    factors = all_factors[n]
    radical = factors.inject(1) {|mem, var| mem * var}
    hash[radical] = (hash[radical] || []) + [n]
  end
  hash
end

def radicals_y(radicals, limit)
  radicals.each do |radical|
    if radical <= Math.sqrt(limit)
      yield radical
    end
  end
end

def radicals_x(radicals, radical_y, limit)
  radicals.each do |radical|
    if radical <= limit / (radical_y ** 2) && radical < radical_y
      yield radical
    end
  end
end

# limit = 10 ** 3
limit = 120000
sum = 0

all_factors = all_factors(limit)
radicals_hash = radicals_hash(all_factors, limit)
radicals = radicals_hash.keys
radicals_y(radicals, limit) do |rad_y|
  radicals_x(radicals, rad_y, limit) do |rad_x|
    # p [rad_x, rad_y]
    radicals_hash[rad_y].each do |y|
      radicals_hash[rad_x].each do |x|
        [x + y, (x - y).abs].each do |z|
          next unless z <= limit && z >= 2
          rad_z = all_factors[z].inject(:*)
          next unless rad_z > rad_y
          abc = [x, y, z].sort
          a = abc[0]
          b = abc[1]
          c = abc[2]
          next if (all_factors[a] + all_factors[b]).uniq.length != all_factors[a].length + all_factors[b].length
          next unless (all_factors[a] + all_factors[b] + all_factors[c]).inject(:*) < c
          # p abc
          sum += c
        end
      end
    end
  end
end

p sum