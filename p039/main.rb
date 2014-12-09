class TriangleCounter
  attr_reader :p

  def initialize(p)
    @p = p
  end

  def count
    output = 0
    (1..(p/3)).each do |a|
      (a..(a + (p - a)/2)).each do |b|
        c = p - a - b
        if c < a + b && (a * a + b * b == c * c)
          output += 1
        end
      end
    end
    output
  end
end

max_count = 0
best_p = 0
LIMIT = 1000

(1..LIMIT).each do |p|
  count = TriangleCounter.new(p).count
  if count > max_count
    max_count = count
    best_p = p
  end
end

puts [best_p, max_count].inspect # [840, 8]