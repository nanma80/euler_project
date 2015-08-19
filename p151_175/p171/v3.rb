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
      # start_time0 = Time.now

      combination_counter += 1
      if combination_counter % 100000 == 0
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

      # @times[0] += Time.now - start_time0
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
    result = @targets.include?(square_sum(count))
    result
  end

end

length = 3  # should be 20

counter = 0
agent = Agent.new(length)
start_time = Time.now
agent.each_count_vector do |count|
  # start_time1 = Time.now
  if agent.hit?(count)
    p [count, agent.square_sum(count)]
    counter += 1
  end
  # agent.times[1] += Time.now - start_time1
end


p counter
p Time.now - start_time
