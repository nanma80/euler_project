# require '../../common'

class Integer
  def factors
    n = self
    factors = []
    factor = 2
    while n > 1
      if n % factor == 0
        n = n / factor
        factors << factor
      else
        factor += 1
      end
    end
    factors
  end
end

found_values = [359125, 469625, 612625, 718250, 781625, 866125, 933725, 939250, 1047625, 1077375, 1119625, 1225250, 1288625, 1336625, 1366625, 1408875, 1436500, 1481125, 1542125, 1563250, 1592825, 1596725, 1732250, 1787125, 1837875, 1867450, 1878500, 1880125, 1914625, 2032225, 2049125, 2095250, 2133625, 2154750, 2203625, 2224625, 2239250, 2251925, 2302625, 2344875, 2387125, 2450500, 2513875, 2577250, 2598375, 2637125, 2673250, 2731625, 2733250, 2801175, 2817750, 2873000, 2894125, 2909125, 2911025, 2962250]

# primes = Prime::Cache.new(1000).primes
# special_primes = primes.select do |prime|
#   prime % 4 == 1
# end

found_values.each do |n|
  histogram = {}
  n.factors.each do |prime|
    if prime % 4 == 1
      histogram[prime] = (histogram[prime] || 0) + 1
    end
  end
  p (histogram.values.inject(1) {|mem, var| mem *= (2 * var + 1)} - 1)/2
  p [n, n.factors]
end

p found_values.inject(:+) 
# sum: 105164200