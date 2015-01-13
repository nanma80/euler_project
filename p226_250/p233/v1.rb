require 'set'
require 'pp'

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
      
      original_triplet = [a, b, c]

      # if c % 5 != 0
      #   original_triplet = [a * 25, b * 25, c * 25]
      # elsif c % 25 != 0
      #   original_triplet = [a * 5, b * 5, c * 5]
      # end

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

def main
  limit = (10 ** 3)
  c_values = []
  lengths = Set.new
  triples_by_c(limit).each do |c, triples|
    lengths << triples.length
    if triples.length == 52
      c_values << c
    end
  end
  p lengths.sort
  p c_values
  p c_values.length
end

def get_f
  limit = (10 ** 3)
  
  pp triples_by_c(limit).to_a.map {|arr| [arr[0], arr[1].length]}.sort
  # p triples_by_c(limit).keys.sort
end

get_f
# main