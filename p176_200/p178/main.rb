def count(n)
  total = 0
  counts = {}
  (1..9).each do |initial_digit|
    signature = [initial_digit, initial_digit, initial_digit]
    counts[signature] = 1
  end

  (2..n).each do
    new_counts = Hash.new { |hash, key| hash[key] = 0 }
    counts.each do |signature, count|
      [-1, 1].each do |offset|
        ending = signature[0]
        min = signature[1]
        max = signature[2]

        new_ending = ending + offset
        if new_ending < 0 || new_ending > 9
          next
        end

        if new_ending < min
          min = new_ending
        end

        if new_ending > max
          max = new_ending
        end

        new_signature = [new_ending, min, max]
        new_counts[new_signature] += count
        if min == 0 && max == 9
          total += count
        end
      end
    end
    counts = new_counts
  end
  # p counts
  total
end

p count(40)