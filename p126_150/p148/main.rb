def main
  limit = 10 ** 9
  base = 7
  limit_string = limit.to_s(base)

  count = 0
  limit_string.length.times do |prefix_length|
    prefix = prefix_length == 0 ? '' : limit_string[0..(prefix_length - 1)]
    current_digit = limit_string[prefix_length].to_i
    next if current_digit == 0
    suffix_length = limit_string.length - prefix_length - 1
    count_plus = 1
    prefix.split('').each do |prefix_char|
      count_plus *= (prefix_char.to_i + 1)
    end

    count_plus *= (0..current_digit-1).to_a.map {|digit| digit + 1}.inject(:+)
    count_plus *= ((1..base).to_a.inject(:+)) ** suffix_length
    count += count_plus
  end
  p count
end

main

