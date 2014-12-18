class String
  def score
    base_ord = 'A'.ord - 1
    self.split('').inject(0) do |sum, c|
      sum += c.ord - base_ord
    end
  end
end
