require 'pp'
require 'set'

def figurate_number(k, n)
  # return the n-th k-gonal number. 
  # Special case: 1 for n = 0, for any k
  n * (n - 1) * (k - 2) / 2 + n
end

def four_digit_figurate_numbers
  limit = 10_000
  numbers = {}
  (3..8).each do |k|
    a = []
    (1..limit).each do |n|
      f = figurate_number(k, n)
      if f < limit
        if f >= 1_000
          a << f
        end
      else
        break
      end
    end
    numbers[k] = a
  end
  numbers
end

numbers = four_digit_figurate_numbers
# p numbers

(3..8).to_a.permutation do |perm|
  next unless perm.first == 3
  
  set = Set.new
  numbers[perm[0]].each do |number|
    set << [number]
  end

  (1..(perm.length - 1)).each do |k_gonal|
    new_numbers = numbers[perm[k_gonal]]
    new_set = Set.new
    
    (0..(numbers.length - 1)).each do |index|
      set.each do |seq|
        last_digits = seq.last.to_s[-2..-1]
        new_numbers.each do |new_number|
          next unless new_number.to_s[0..1] == last_digits
          new_set << seq + [new_number]
        end
      end
    end
    set = new_set
  end
  
  set.each do |seq|
    if seq.first.to_s[0..1] == seq.last.to_s[-2..-1]
      p seq
      p seq.inject(0) { |mem, var|  mem + var}

      exit
    end
  end
end

# set = Set.new
# numbers.first.each do |number|
#   set << [number]
# end

# limit = 2
# (1..(limit - 1)).each do |k_gonal|
#   new_numbers = numbers[k_gonal]
#   new_set = Set.new
  
#   (0..(numbers.length - 1)).each do |index|
#     set.each do |seq|
#       last_digits = seq.last.to_s[-2..-1]
#       new_numbers.each do |new_number|
#         next unless new_number.to_s[0..1] == last_digits
#         new_set << seq + [new_number]
#       end
#     end
#   end
#   set = new_set
# end
# p set
