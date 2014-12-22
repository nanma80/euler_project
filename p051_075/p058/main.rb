require '../../common'

def spiral_diagonal(max_layer)
  cache = [ 1 ]
  max_layer.times do |index|
    number = cache.last
    size = index * 2 + 3
    step = size - 1
    yield [ cache, index * 2 + 1 ]
    cache = [number + step, number + 2* step, number + 3 * step, number + 4 * step]
  end
end

count_all = 0
count_primes = 0

spiral_diagonal(30000) do |c|
  diags = c[0]
  size = c[1]

  count_all += diags.length
  diags.each do |i|
    count_primes += 1 if i.is_prime?
  end

  if 1.0 * count_primes / count_all < 0.1 && size > 1
    p size
    exit
  end
end
