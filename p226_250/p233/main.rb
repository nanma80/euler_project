require 'set'

def triples(limit)
  output = Set.new

  m_limit = Math.sqrt(limit).to_i

  (-5..m_limit-1).each do |m|
    next if m == 0
    (m+1..m_limit).each do |n|
      next if n == 0
      next if (m - n) % 2 == 0

      a = (m * m + 2 * m * n - n * n).abs
      b = (- m * m + 2 * m * n + n * n).abs
      c = m * m + n * n
      break if c > limit
      a, b = b, a if a > b
      
      if c % 5 != 0
        original_triplet = [a * 25, b * 25, c * 25]
      elsif c % 25 != 0
        original_triplet = [a * 5, b * 5, c * 5]
      else
        original_triplet = [a, b, c]
      end

      if !(output.include?(original_triplet))
        triplet = original_triplet.dup
        while triplet.last <= limit
          output << triplet
          triplet = [triplet, original_triplet].transpose.map {|arr| arr.inject(:+)}
        end
      end
    end
  end
  output
end

def triples_by_c(limit)
  output = {}
  triples(limit).each do |triple|
    c = triple.last
    output[c] = (output[c] || []) + [triple]
  end
  output
end

limit = (10 ** 6)
c_values = []
triples_by_c(limit).each do |c, triples|
  if triples.length == 52
    c_values << c
  end
end
p c_values
p c_values.length