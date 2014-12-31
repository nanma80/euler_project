class Integer
  def factors
    n = self
    factors = []
    factor = 2
    while n > 1
      if n % factor == 0
        n = n / factor
        factors << factor
      else
        factor += 1
      end
    end
    factors
  end
end