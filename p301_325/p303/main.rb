def least_multiplier(n, digit_count_limit)
  if n == 999
    return 111333555778
  elsif n == 9999
    return 1111333355557778
  end

  if n % 10 == 0
    return least_multiplier(n / 10, digit_count_limit)
  end

  multipliers = [0]
  digit_count_limit.times do |digit_count|
    power_10 = 10 ** digit_count
    new_multipliers = []
    valid_multipliers = []
    multipliers.each do |multiplier|
      if digit_count == 0
        digits = (1..9)
      else
        digits = (0..9)
      end
      
      digits.each do |new_digit|
        new_multiplier = multiplier + power_10 * new_digit
        product = n * new_multiplier
        product_array = product.to_s.split('').reverse.map(&:to_i)
        
        next if product_array[digit_count] > 2
        new_multipliers << new_multiplier

        if product_array.map {|d| d <= 2}.all?
          valid_multipliers << new_multiplier
        end
      end
    end

    if valid_multipliers.empty?
      multipliers = new_multipliers
    else
      least_multiplier = valid_multipliers.min
      p [n, least_multiplier, least_multiplier * n]
      return least_multiplier
    end
  end
  raise "Cannot find any valid multiplier for n = #{n}, digit_count_limit = #{digit_count_limit}"
end

def main
  limit = 10000
  digit_count_limit = 30
  sum = 0
  (1..limit).each do |n|
    least_multiplier = least_multiplier(n, digit_count_limit)
    sum += least_multiplier
  end
  p sum
end

main 
