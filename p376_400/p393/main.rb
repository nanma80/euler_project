require 'pp'
require 'benchmark'

def next_boundaries(boundary, row_index, column_index)
  size = boundary.length / 2
  ignore_front = size - 1 - row_index + column_index
  active_boundary = boundary[ignore_front..ignore_front + 1].map {|_k| - _k }
  candidates = [0, 0, 1, -1]
  active_boundary.each do |_k|
    _index = candidates.index(_k)
    if _index.nil?
      return []
    else
      candidates.delete_at(_index)
    end
  end

  replacements = [candidates, candidates.reverse].uniq
  if column_index == size - 1
    replacements.select! {|_array| _array[1] == 0}
  end

  if row_index == size - 1
    replacements.select! {|_array| _array[0] == 0}
  end

  next_boundaries = []
  replacements.each do |replacement|
    next_boundary = boundary.dup
    [0, 1].each do |offset|
      next_boundary[ignore_front + offset] = replacement[offset]
    end
    next_boundaries << next_boundary
  end
  next_boundaries
end

def main
  size = 10
  boundaries = Hash.new { |hash, key| hash[key] = 0 }
  original_boundary = [0] * (size * 2)
  boundaries[original_boundary] += 1
  size.times do |row_index|
    size.times do |column_index|
      p [row_index, column_index, boundaries.length]
      new_boundaries = Hash.new { |hash, key| hash[key] = 0 }
      boundaries.each do |boundary, count|
        next_boundaries(boundary, row_index, column_index).each do |next_boundary|
          new_boundaries[next_boundary] += count
        end
      end
      boundaries = new_boundaries
    end
  end
  p boundaries[original_boundary]
end

p Benchmark.measure { main }
