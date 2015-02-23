require 'benchmark'

class Integer
  def digital_root
    if self > 0
      ((self - 1) % 9) + 1
    else
      0
    end
  end
end

class Agent
  attr_reader :limit, :max_digital_root_sums

  def initialize(limit)
    @limit = limit
    populate_max_digital_root_sums
  end

  def populate_max_digital_root_sums
    @max_digital_root_sums = [0] * (limit + 1)
    (2..limit).each do |n|
      max_digital_root_sum = [@max_digital_root_sums[n], n.digital_root].max
      @max_digital_root_sums[n] = max_digital_root_sum

      multiplier = 2
      multiple = multiplier * n

      while multiple <= limit
        digital_root_sum = multiplier.digital_root + max_digital_root_sum
        if digital_root_sum > @max_digital_root_sums[multiple]
          @max_digital_root_sums[multiple] = digital_root_sum
        end
        multiple += n
        multiplier += 1
      end
      max_digital_root_sum
    end
  end
end

def main
  limit = 10 ** 6 - 1
  agent = Agent.new(limit)

  p agent.max_digital_root_sums.inject(:+)
end

puts Benchmark.measure { main }

