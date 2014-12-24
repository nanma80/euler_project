def key(number)
  number.to_s.split('').sort.join
end

def digits(limit)
  dict = {}
  (1..limit).each do |n|
    cube = n ** 3
    key = key(cube)
    dict[key] = (dict[key] || []) + [cube]
  end
  dict
end

min_cube = nil
digits = digits(10000)
digits.each do |seq, cubes|
  if cubes.length >= 5
    m_cube = cubes.min
    if min_cube.nil? || min_cube > m_cube
      min_cube = m_cube
    end
  end
end

p min_cube
