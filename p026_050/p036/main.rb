limit = 1_000_000
bases = [2, 10]

sum = 0

(0..limit).each do |number|
  is_double_base_palindromic = true
  bases.each do |base|
    string = number.to_s(base)
    if string != string.reverse
      is_double_base_palindromic = false
    end
  end
  
  if is_double_base_palindromic
    # p number
    sum += number
  end
end

p sum