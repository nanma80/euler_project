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

def perimeters(limit)
  perimeters = {}
  (2..Math.sqrt(limit)).each do |m|
    (1..(m-1)).each do |n|
      next if (m - n) % 2 == 0
      original_triplet = triplet(m, n)
      original_perimeter = original_triplet.inject(:+)

      triplet = original_triplet.dup
      perimeter = original_perimeter
      while perimeter <= limit

        if perimeters[perimeter].nil?
          perimeters[perimeter] = Set.new([triplet])
        else
          if perimeters[perimeter].include?(triplet)
            break
          else
            perimeters[perimeter] << triplet
          end
        end

        perimeter += original_perimeter
        triplet = [triplet, original_triplet].transpose.map do |array|
          array[0] + array[1]
        end
      end
    end
  end
  perimeters
end

count = 0
perimeters(1_500_000).each do |perimeter, ways|
  count += 1 if ways.length == 1
end

p count
