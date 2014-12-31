blue = [1, 3]

while blue.last * Math.sqrt(2) < 10 ** 12
  blue << 6 * blue[-1] - blue[-2] - 2
end

p blue.last