limit = 50

count = 0

(0..limit).each do |x1|
  (0..limit).each do |y1|
    next if x1 + y1 == 0

    (0..limit).each do |x2|
      (0..limit).each do |y2|
        next if x2 + y2 == 0
        next if (x2 - x1) + (y2 - y1) * Math.sqrt(2) <= 0

        inner_12 = x1 * x2 + y1 * y2

        x3 = x2 - x1
        y3 = y2 - y1
        inner_13 = x1 * x3 + y1 * y3
        inner_23 = x2 * x3 + y2 * y3

        if inner_12 == 0 || inner_13 == 0 || inner_23 == 0
          count += 1
        end
      end
    end
  end
end

p count