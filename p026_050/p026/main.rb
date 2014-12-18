def cycle_length(d, base = 10)
  buffer = {}
  position = 0
  residue = 1

  while residue != 0 && !(buffer.has_key?(residue))
    buffer[residue] = position
    position += 1
    residue = (residue * base) % d
  end

  if residue == 0
    return 0
  else
    return position - buffer[residue]
  end
end

max_l = 0
max_d = 0
(1..999).each do |d|
  l = cycle_length(d)
  if l > max_l
    max_l = l
    max_d = d
  end
end

p max_d
# p max_l