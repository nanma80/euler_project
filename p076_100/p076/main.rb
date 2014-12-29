class Ways
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

p Ways.new.ways(100) - 1
