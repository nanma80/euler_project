def ulam(first, second, length)
  output = [first, second]

  (length - 2).times do 
    sums = Hash.new { |hash, key| hash[key] = 0 }

    output.combination(2) do |comb|
      sum = comb[0] + comb[1]
      next if sum <= output.last
      sums[comb[0] + comb[1]] += 1
    end

    minimum_unique_sum = nil
    sums.each do |sum, duplicate|
      if duplicate == 1 && (minimum_unique_sum.nil? || sum < minimum_unique_sum)
        minimum_unique_sum = sum
      end
    end
    output << minimum_unique_sum
  end
  output
end

p ulam(2, 5, 10)