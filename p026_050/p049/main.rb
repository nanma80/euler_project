require '../../common'

LIMIT = 10000

def key(number)
  number.to_s.split('').sort.join
end

def perm_dict(numbers)
  dict = {}
  numbers.each do |number|
    key = key(number)
    if dict[key]
      dict[key] << number
    else
      dict[key] = [number]
    end
  end
  dict
end

def contains_arith(array)
  return false if array.length < 3
  (0..(array.length-1)).each do |i|
    ((i + 1)..(array.length-1)).each do |j|
      mid_value = (array[i] + array[j]) / 2
      if array.include? mid_value
        puts [array[i], mid_value, array[j]].map(&:to_s).join

        return true
      end
    end
  end
  false
end

primes = Prime::Cache.new(LIMIT).primes

perm_dict(primes).each do |_key, value|
  next if value.length < 3
  next unless contains_arith(value)
end
