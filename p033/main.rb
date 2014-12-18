def check(number1, number2)
  canceled = cancel(number1, number2)
  if canceled.nil?
    false
  else
    check_fraction(canceled, [number1, number2])
  end
end

def check_fraction(array1, array2)
  array1.first * array2.last == array1.last * array2.first
end

def cancel(number1, number2)
  digits1 = digits(number1)
  digits2 = digits(number2)
  common = common_element(digits(number1), digits(number2))
  if common.nil? || common == 0
    nil
  else
    digits1.slice!(digits1.index(common))
    digits2.slice!(digits2.index(common))
    # digits1.delete(common)
    # digits2.delete(common)
    [digits1.first, digits2.first]
  end
end

def common_element(array1, array2)
  array1.each do |element1|
    return element1 if array2.include? element1
  end
  nil
end

def digits(number)
  number.to_s.split('').map(&:to_i)
end

product = [1, 1]

(10..99).each do |up|
  ((up + 1)..99).each do |down|
    if check(up, down)
      product = [product.first * up, product.last * down]
    end
  end
end

p product # [387296, 38729600] ~ 1/100. Answer is 100