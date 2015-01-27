def each_maximix(length)
  elements = (0..length - 1).to_a
  elements.permutation do |perm|
    next if perm[0] == 0
    original_perm = perm.dup
    is_maximix = true
    (length - 2).times do |index|
      if perm[index] == index || perm[-1] == index
        is_maximix = false
        break
      end
      break unless is_maximix
      from_index = perm.index(index)
      prefix = index == 0 ? [] : perm[0..index - 1]
      new_perm = prefix + perm[from_index..-1] + perm[index..from_index - 1].reverse
      perm = new_perm
    end

    if perm[-1] == length - 1
      is_maximix = false
    end

    if is_maximix
      yield original_perm
    end
  end
end

def int_to_alpha(int_array)
  int_array.map do |int|
    ('A'.ord + int).chr
  end.join
end

index = 2011
car_count = 11

count = 0
perms = []
each_maximix(car_count) do |perm|
  perms << perm
  count += 1
  puts count if count % 100 == 0
  if count == index
    puts int_to_alpha(perm)
    break
  end
end

puts perms.length
