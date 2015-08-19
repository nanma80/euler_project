class Agent
  attr_reader :length, :blocks, :max_sum, :targets
  attr_accessor :counts

  def initialize(length)
    @length = length
    @max_sum = length * (9 ** 2)
    @targets = (1..Math.sqrt(max_sum).to_i).map{|n| n ** 2}
    @combinations = []
    @blocks = (2..9).to_a.map{|digit| digit ** 2}
    @counts = [0] * blocks.length
  end

  def total_count
    counts.inject(:+)
  end

  def increment
    pointer = 0
    while pointer < blocks.length
      counts[pointer] += 1

      if total_count <= length
        return true
      end

      counts[pointer] = 0
      pointer += 1
    end
    false
  end
end

length = 2  # should be 20

agent = Agent.new(length)

while agent.increment
  p agent.counts
end