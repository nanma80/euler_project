# https://oeis.org/A000041
# a(n) = (1/n) * Sum_{k=0, 1, ..., n-1} sigma(n-k)*a(k), 
# where sigma(k) is the sum of divisors of k

class PartitionNumber
  attr_reader :sigma, :limit

  def initialize(limit)
    @limit = limit
    @sigma = get_sigma
    @cache = [1]
  end

  def get_sigma
    sigma = [1] * (limit + 1)
    (2..limit).each do |factor|
      n = factor
      while n <= limit
        sigma[n] += factor
        n += factor
      end
    end
    puts "Cached #{sigma.length} sigmas"
    sigma
  end

  def each_partitions
    (1..limit).each do |n|
      puts "Working on #{n}" if n % 100 == 0
      sum = 0
      (0..(n-1)).each do |k|
        sum += sigma[n - k] * @cache[k]
      end
      sum = sum / n
      @cache[n] = sum
      yield n, sum
    end
  end
end

limit = 10 ** 5
target = 10 ** 6

partition_number = PartitionNumber.new(limit)
partition_number.each_partitions do |n, way|
  if way % target == 0
    puts "#{n}: #{way}"
    exit
  end
end
