require 'set'

def period(numerator, denominator, limit = 100)
  remainder = numerator
  seen_remainders = {}
  quotients = []
  limit.times do |digit_position|
    new_remainder = (remainder * 10) % denominator
    unless seen_remainders[new_remainder].nil?
      return quotients[seen_remainders[new_remainder]..-1]
    end
    quotients << (remainder * 10) / denominator

    seen_remainders[new_remainder] = digit_position
    remainder = new_remainder
  end
  puts "Period longer than limit #{limit}: #{numerator}/#{denominator}"
  quotients
end

def main
  sum = 0
  max_digit_count = 100

  k_range = [2,3,4,5,6,7,8,9]
  k_range.each do |k|
    (k..9).each do |i|
      period = period(i, 10 * k - 1)
      multiple = max_digit_count / (period.length)
      last_digits = period[-5..-1].map(&:to_s).join.to_i
      sum += last_digits * multiple
      sum = sum % (10 ** 5)
      # p [last_digits, multiple]
    end
  end

  (2..max_digit_count).each do |digit_count|
    (1..9).each do |digit|
      period = [digit] * digit_count
      last_digits = period[-[5, period.length].min..-1].map(&:to_s).join.to_i
      sum += last_digits
      sum = sum % (10 ** 5)
    end
  end

  p sum
end

main
