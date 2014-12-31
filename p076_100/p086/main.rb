require 'set'

def triplet(m, n)
  a = m * m - n * n
  b = 2 * m * n
  c = m * m + n * n
  if a < b
    [a, b, c]
  else
    [b, a, c]
  end
end

def triplets(limit)
  triplets = Set.new
  (2..Math.sqrt(limit)).each do |m|
    (1..(m-1)).each do |n|
      next if (m - n) % 2 == 0
      original_triplet = triplet(m, n)

      triplet = original_triplet.dup
      while triplet[0] <= limit && triplet[1] <= limit
        triplets << triplet
        triplet = [triplet, original_triplet].transpose.map do |array|
          array[0] + array[1]
        end
      end
    end
  end
  triplets
end


def cubes(triplet, limit)
  (0..1).each do |i|
    a = triplet[i]
    bc = triplet[1-i]
    if a <= limit
      bc.times do |b|
        c = bc - b
        next if b < 1 || c > a
        break if b > a
        if c < b
          yield [c, b, a]
        else
          yield [b, c, a]
        end        
      end
    end
  end
end

m = 1818

triplets = triplets(2 * m)

good_cubes = Set.new

triplets.each_with_index do |triplet, index|
  cubes(triplet, m) do |cube|
    good_cubes << cube
  end
end

puts "m = #{m}: #{good_cubes.length}"
