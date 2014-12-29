require '../../common'

class SumCache
  attr_reader :cache, :primes

  def initialize(limit)
    @primes = Prime::Cache.new(limit).primes
    @cache = {}
    @cache[[0, 0]] = 1
    @cache[[1, 1]] = 0
  end

  def ways(sum, max = nil)
    max = sum if max.nil? || max > sum
    return @cache[[sum, max]] unless @cache[[sum, max]].nil?
    count = 0
    primes.each do |prime|
      break if prime > sum || prime > max
      count += ways(sum - prime, prime)
    end
    @cache[[sum, max]] = count
  end
end

limit = 200
sum_cache = SumCache.new(limit)

(2..limit).each do |n|
  ways = sum_cache.ways(n)
  # puts "#{n}\t#{ways}"
  if ways > 5000
    puts n
    exit
  end
end
