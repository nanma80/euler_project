require 'set'

def each_tuple(size)
  limit = 2 ** size
  limit.times do |generator|
    yield (generator + limit).to_s(2)[1..-1].split('').map(&:to_i)
  end
end

def cycle(array)
  if array.length < 3
    raise "Length of array must be at least 3. Current: #{array.length}"
  end

  last_element = (array[0] ^ (array[1] & array[2]))
  array[1..-1] + [ last_element ]
end

def mapping(size)
  mapping = {}

  each_tuple(size) do |tuple|
    mapping[tuple] = cycle(tuple)
  end

  mapping
end

def cycles(size)
  mapping = mapping(size)
  cycles = []
  
  until mapping.empty?
    current_cycle = 0
    from_tuple = mapping.keys.first
    start_tuple = from_tuple
    to_tuple = nil

    until to_tuple == start_tuple
      current_cycle += 1
      to_tuple = mapping[from_tuple]
      mapping.delete(from_tuple)
      from_tuple = to_tuple
    end
    cycles << current_cycle
  end

  cycles.sort
end

def count(cycle_length)
  counts_begin_end = Hash.new(0)
  counts_begin_end[[0, 0]] = 1
  counts_begin_end[[1, 1]] = 1
  

  (2..cycle_length).each do
    new_counts = {}
    new_counts[[0, 0]] = counts_begin_end[[0, 0]] + counts_begin_end[[0, 1]]
    new_counts[[0, 1]] = counts_begin_end[[0, 0]]
    new_counts[[1, 0]] = counts_begin_end[[1, 0]] + counts_begin_end[[1, 1]]
    new_counts[[1, 1]] = counts_begin_end[[1, 0]]
    counts_begin_end = new_counts
  end
  
  counts_begin_end[[0, 0]] + counts_begin_end[[0, 1]] + counts_begin_end[[1, 0]]
end

def main
  size = 6
  product = 1
  cycles(size).each do |cycle|
    product *= count(cycle)
  end
  p product
end

main