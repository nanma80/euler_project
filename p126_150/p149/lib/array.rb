class Array
  def max_sum
    max_sum_including_last = 0
    max_sum_excluding_last = 0
    self.each do |current|
      max_sum_including_last = [max_sum_including_last + current, current].max
      max_sum_excluding_last = [max_sum_excluding_last, max_sum_including_last].max
    end
    [max_sum_including_last, max_sum_excluding_last].max
  end
end

