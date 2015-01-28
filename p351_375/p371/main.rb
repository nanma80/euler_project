def value(limit)
  raise unless limit % 2 == 0
  k = limit / 2
  values = {}
  values[[0, k]] = 0.0
  values[[1, k]] = 0.0
  k.times do |r|
    values[[2, r]] = 0.0
  end
  (0..k - 1).to_a.reverse.each do |r|
    [1, 0].each do |h|
      values[[h, r]] = 2.0 * k / (2.0 * k - r - 1) +
        values[[h + 1, r]] / (2.0 * k - r - 1) +
        (2.0 * k - 2.0 * r - 2) / (2.0 * k - r - 1) * values[[h, r + 1]]
    end
  end
  values[[0, 0]]
end

p value(1000)