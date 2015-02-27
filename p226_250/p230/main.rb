def dab(a, b, n)
  lengths = [a.length, b.length]
  while lengths.last < n
    lengths << lengths[-1] + lengths[-2]
  end

  pointer = lengths.length - 1
  position = n - 1
  while pointer > 1
    first_part = lengths[pointer - 2]
    if position < first_part
      pointer -= 2
    else
      pointer -= 1
      position -= first_part
    end
  end
  if pointer == 0
    a[position].to_i
  else
    b[position].to_i
  end
end

def test
  a = '1415926535'
  b = '8979323846'
  puts dab(a, b, 35)
end

def main
  a = '1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679'
  b = '8214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196'
  
  sum = 0
  (0..17).each do |n|
    sum += (10 ** n) * (dab(a, b, (127 + 19 * n) * (7 ** n)))
  end
  p sum
end

# test
main