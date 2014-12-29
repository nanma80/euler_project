# copied from p076
class Ways
  attr_reader :cache

  def initialize
    @cache = {}
  end


  def ways(sum, max = nil)
    max = sum if max.nil? || max > sum
    return @cache[[sum, max]] unless @cache[[sum, max]].nil?
    # including [sum] itself
    return 1 if sum == 0
    count = 0
    (1..max).each do |first|
      count += ways(sum - first, first)
    end
    @cache[[sum, max]] = count
  end
end

cache = Ways.new

(1..1000).each do |n|
  ways = cache.ways(n)
  puts "#{n}\t#{cache.ways(n)}"
  if ways % (10 ** 6) == 0
    puts n
    exit
  end
end

# no luck