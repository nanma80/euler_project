require 'set'

def strong_repunits(exclusive_limit)
  base_limit = Math.sqrt(exclusive_limit).to_i
  repunits = Set.new
  repunits << 1
  (2..base_limit).each do |base|
    (3..Math.log(exclusive_limit, base).to_i + 1).each do |power|
      repunit = (base ** power - 1) / (base - 1)
      if repunit < exclusive_limit
        repunits << repunit
      end
    end
  end
  repunits
end

limit = 10 ** 12
repunits = strong_repunits(limit)
p repunits.inject(:+)