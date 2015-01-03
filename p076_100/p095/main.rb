require 'set'

class Cache
  attr_reader :limit

  def initialize(limit)
    @limit = limit
  end

  def divisor_sums
    return @divisor_sums unless @divisor_sums.nil?
    
    @divisor_sums = [1] * (limit + 1)
    @divisor_sums[0] = 0
    (2..limit).each do |factor|
      position = factor * 2
      while position <= limit
        @divisor_sums[position] += factor
        position += factor
      end
    end
    @divisor_sums
  end

  def chains
    return @chains unless @chains.nil?

    @chains = Set.new

    (0..limit).each do |start_index|
      current = start_index
      path = [current]
      current = divisor_sums[current]

      until (path.include?(current)) || (current > limit)
        path << current
        current = divisor_sums[current]
      end

      if current == start_index
        @chains << path
      end
    end
    @chains
  end
end

cache = Cache.new(10 ** 6)

longest_length = 0
longest_chain = nil
cache.chains.each do |chain|
  if chain.length > longest_length
    longest_length = chain.length
    longest_chain = chain
  end
end

puts "Longest chain:"
p longest_chain
puts "Minimum of the chain:"
p longest_chain.min
