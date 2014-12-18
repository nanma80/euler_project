def digits
  digits = []
  (0..9).each do |digit|
    digits << digit.to_s
  end
  digits
end

def is_good?(string)
  string[7..9].to_i % 17 == 0 &&
  string[6..8].to_i % 13 == 0 &&
  string[5..7].to_i % 11 == 0 &&
  string[4..6].to_i % 7 == 0 &&
  string[3..5].to_i % 5 == 0 &&
  string[2..4].to_i % 3 == 0 &&
  string[1..3].to_i % 2 == 0
end

sum = 0
digits.permutation do |perm|
  string = perm.join
  if is_good?(string)
    # puts string
    sum += string.to_i
  end
end

p sum # 16695334890
