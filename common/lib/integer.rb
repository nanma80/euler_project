class Integer
  def is_prime?
    return false if self < 2
    factor = 2
    while factor * factor <= self
      return false if self % factor == 0
      factor += 1
    end
    true
  end
end
