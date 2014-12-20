require '../../common'
require 'pp'

limit = 10 ** 6
replacement_count = 8

def keys(string)
  length = string.length
  max_index = 2 ** length - 1
  (1..max_index).each do |index|
    index_string = index.to_s(2)
    index_string = '0' * (length - index_string.length) + index_string
    
    key = ''
    replaced = nil
    valid = true

    length.times do |position|
      if index_string[position] == '0'
        key << string[position]
      else
        key << '*'
        if replaced.nil?
          replaced = string[position]
        else
          if replaced != string[position]
            valid = false
          end
        end
      end
    end
    yield key if valid
  end
end

primes = Prime::Cache.new(limit).primes

dict = {}

primes.each do |prime|
  keys(prime.to_s) do |key|
    if dict[key].nil?
      dict[key] = [prime]
    else
      dict[key] << prime
    end
  end
end

dict.each do |key, value|
  p [key, value] if value.length >= replacement_count
end

# ["*2*3*3", [121313, 222323, 323333, 424343, 525353, 626363, 828383, 929393]]
