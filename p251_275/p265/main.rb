require 'set'

def each_sequence(tile_length, prefix, seen)
  length = 2 ** tile_length + tile_length - 1
  if length == prefix.length
    return yield prefix
  end

  [0, 1].each do |new_bit|
    prefix_candidate = prefix + [new_bit]
    new_tile = prefix_candidate[-tile_length..-1]
    next if seen.include?(new_tile)
    seen_dup = seen.dup
    seen_dup << new_tile
    each_sequence(tile_length, prefix_candidate, seen_dup) do |seq|
      yield seq
    end
  end
end

def sum_representations(tile_length)
  sum = 0
  seed = [0] * tile_length
  seen = Set.new([seed])
  each_sequence(tile_length, seed, seen) do |seq|
    sum += seq[0..- tile_length].map(&:to_s).join.to_i(2)
  end
  sum
end

p sum_representations(5)