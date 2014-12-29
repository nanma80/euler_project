require 'pp'
# copied from p076
class Ways
  attr_reader :cache

  def initialize
    @cache = {}
    @cache[[0, 0]] = 1
  end


  def ways(sum, max = nil)
    max = sum if max.nil? || max > sum
    return @cache[[sum, max]] unless @cache[[sum, max]].nil?
    
    count = 0
    (1..max).each do |first|
      count += ways(sum - first, first)
    end
    @cache[[sum, max]] = count
  end
end

cache = Ways.new

(1..1000000).each do |n|
  ways = cache.ways(n)
  puts "#{n}\t#{cache.ways(n)}"
  if ways % (10 ** 6) == 0
    puts "Found: #{n}"
    exit
  end
end

# pp cache.cache.to_a.sort_by {|key, value| key}
# Correct. But too slow to find the answer