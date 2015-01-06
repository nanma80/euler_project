require '../../common'
require 'set'

def each_split(array)
  return if array.empty?
  generator_limit = 2 ** (array.length - 1)
  (generator_limit + 1..2 * generator_limit - 1).each do |generator|
    front = [array.first]
    back = []
    mask = generator.to_s(2)[1..-1].split('')
    mask.each_with_index do |char, i|
      if char == '0'
        front << array[i + 1]
      else
        back << array[i + 1]
      end
    end
    yield front, back
  end
end

def prime_permutations(array, prime_cache)
  output = Set.new
  return output if array.length > 1 && array.inject(:+) % 3 == 0

  array.permutation do |perm|
    number = perm.map(&:to_s).join.to_i
    if prime_cache.is_prime?(number)
      output << [number] 
    end
  end
  output
end

limit = 9
cache_limit = 10 ** 6
prime_cache = Prime::Cache.new(cache_limit)

prime_sets = {}
alphabet = (1..limit).to_a

(1..limit).each do |digit_count|
  alphabet.combination(digit_count) do |combi|
    set = prime_permutations(combi, prime_cache)
    each_split(combi) do |front, back|
      prime_sets[front].each do |front_prime|
        prime_sets[back].each do |back_prime|
          set << (front_prime + back_prime).sort
        end
      end
    end
    prime_sets[combi] = set
  end
end

p prime_sets[alphabet].length
