require 'set'
require '../../common'

class Agent
  attr_reader :length, :blocks, :max_sum, :targets, :combinations
  attr_accessor :counts, :times

  def initialize(length)
    @length = length
    @max_sum = length * (9 ** 2)
    @targets = Set.new((1..Math.sqrt(max_sum).to_i).map{|n| n ** 2})
    @combinations = []
    # @times = [0.0, 0.0]
  end

  def each_count_vector
    total_count = (length + 9).choose(9)
    combination_counter = 0

    (1..length + 9).to_a.combination(9) do |separators|
      combination_counter += 1
      if combination_counter % 1000000 == 0
        puts "#{combination_counter * 100 / total_count}%\t#{Time.now}"
      end
      
      count = []
      previous = 0
      separators.each_with_index do |s, index|
        if index == 0
          count << s - 1
        else
          count << s - previous - 1
        end
        previous = s
      end
      count << length + 9 - previous

      yield count
    end
  end

  def square_sum(count)
    sum = 0
    count.each_with_index do |c, index|
      sum += c * index * index
    end
    
    sum
  end

  def hit?(count)
    @targets.include?(square_sum(count))
  end

  def to_a(count)
    array = []
    count.each_with_index do |c, index|
      array += [index] * c
    end
    array
  end

  def multinomial(count)
    output = count.inject(:+).factorial
    count.each do |c|
      output /= c.factorial
    end
    output
  end

  def perm_sum(count)
    output = multinomial(count)
    weighted_sum = 0
    count.each_with_index do |c, index|
      weighted_sum += c * index
    end
    output * weighted_sum / count.inject(:+)
  end

  def all_combos(count)
    all_combos = Set.new
    to_a(count).permutation do |perm|
      all_combos << perm.map(&:to_s).join.to_i
    end
    all_combos
  end
end


length = 20  # should be 20
mod = 10 ** 9
agent = Agent.new(length)
sum = 0

start_time = Time.now
agent.each_count_vector do |count|
  if agent.hit?(count)
    sum += agent.perm_sum(count)
  end
end

sum *= (10 ** length - 1) / 9
sum %= mod


p Time.now - start_time
p sum
