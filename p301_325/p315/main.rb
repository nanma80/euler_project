require '../../common'

class Integer
  def to_led
    case self
    when 0
      [true, false, true, true, true, true, true]
    when 1
      [false, false, false, false, true, false, true]
    when 2
      [true, true, true, false, true, true, false]
    when 3
      [true, true, true, false, true, false, true]
    when 4
      [false, true, false, true, true, false, true]
    when 5
      [true, true, true, true, false, false, true]
    when 6
      [true, true, true, true, false, true, true]
    when 7
      [true, false, false, true, true, false, true]
    when 8
      [true, true, true, true, true, true, true]
    when 9
      [true, true, true, true, true, false, true]
    end
  end
end

def sequence(start_number)
  current = start_number
  sequence = [current]
  while current >= 10
    current = current.to_s.split('').map(&:to_i).inject(:+)
    sequence << current
  end
  sequence
end

def saving(start_number)
  saving = 0
  sequence = sequence(start_number)
  (1..sequence.length - 1).each do |index2|
    digits1 = sequence[index2 - 1].to_s.split('').map(&:to_i)
    digits2 = sequence[index2].to_s.split('').map(&:to_i)
    digits2.length.times do |digit_position|
      digit1 = digits1[-1 - digit_position]
      digit2 = digits2[-1 - digit_position]
      diff = [digit1, digit2].map(&:to_led)
        .transpose
        .map {|arr| (arr[0] & arr[1])? 1 : 0}
        .inject(:+)
      saving += diff * 2
    end
  end
  saving
end

def main
  limit = 2 * (10 ** 7)
  prime_cache = Prime::Cache.new(limit)
  puts 'Primes cached'
  total = 0
  (limit/2..limit).each do |n|
    puts n if n % (10 ** 5) == 0
    if prime_cache.prime_check[n]
      total += saving(n)
    end
  end
  p total
end

main
