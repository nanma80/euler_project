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

def right_triangles(limit)
  (2..Math.sqrt(limit)).each do |m|
    (1..(m-1)).each do |n|
      next if (m - n) % 2 == 0
      original_triplet = triplet(m, n)
      triplet = original_triplet.dup
      
      while triplet.last <= limit
        yield triplet

        triplet = [triplet, original_triplet].transpose.map do |array|
          array[0] + array[1]
        end
      end
    end
  end
end

def triangles_by_edges(limit)
  triangles_by_edges = {}
  right_triangles(limit) do |triplet|
    (0..1).each do |i|
      edge = triplet[i]
      if triangles_by_edges[edge].nil?
        triangles_by_edges[edge] = Set.new([triplet])
      else
        triangles_by_edges[edge] << triplet
      end
    end
  end
  triangles_by_edges
end

def triangles(limit)
  triangles_by_edges = triangles_by_edges(limit)
  triangles_by_edges.each do |edge, right_triangles|
    next if right_triangles.length < 3
    right_triangles.to_a.combination(3) do |combi|
      
      as = []
      cs = []
      right_triangles_area = 0
      combi.each do |right_triangle|
        cs << right_triangle[2]
        as << right_triangle[0] + right_triangle[1] - edge
        right_triangles_area += right_triangle[0] * right_triangle[1]
      end
      sides = [as[0] + as[1], as[0] + as[2], as[1] + as[2]]
      perimeter = sides.inject(:+)
      next if perimeter > limit

      half_perimeter = perimeter / 2
      
      area_sq = half_perimeter

      sides.each do |side|
        area_sq *= (half_perimeter - side)
      end
      area = Math.sqrt(area_sq)
      
      next if area != right_triangles_area

      p [perimeter, sides]
      puts perimeter + cs.inject(:+)
    end
  end
end

triangles(1500)
