class Integer
  def factorial
    if self > 1
      (2..self).inject(:*)
    else
      1
    end
  end
end
