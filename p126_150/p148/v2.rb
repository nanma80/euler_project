require 'benchmark'

class Agent
  attr_reader :cache

  def initialize
    @cache = {}
  end

  def count_not_divisible(n, prime)
    char_array = n.to_s(prime).split('')
    sorted_array = char_array.sort
    unless @cache[sorted_array].nil?
      return @cache[sorted_array]
    end

    histogram = [0] * prime
    
    sorted_array.each do |char|
      histogram[char.to_i] += 1
    end

    count = 1
    histogram.each_with_index do |occurrence, remainder|
      count *= (remainder + 1) ** occurrence
    end
    @cache[sorted_array] = count
    count
  end
end

def main
  limit = 10 ** 5

  agent = Agent.new
  count = 0
  (0..limit - 1).each do |layer|
    # p [layer, count] if layer % (10 ** 6) == 0
    count += agent.count_not_divisible(layer, 7)
  end

  p count
end

p Benchmark.measure { main }
