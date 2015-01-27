def main
  limit = 2 ** 30

  count = 0
  (1..limit).each do |n|
    p n if n % (10 ** 6) == 0
    if (n ^ (2 * n) ^ (3 * n)) == 0
      count += 1
    end
  end
  p count
end

main