class Integer
  def proper_divisors
    proper_divisors = [1]
    factor = 2
    while factor * factor < self
      proper_divisors += [factor, self / factor] if self % factor == 0
      factor += 1
    end

    proper_divisors << factor if factor * factor == self

    proper_divisors
  end

  def sum_proper_divisors
    proper_divisors.inject(:+)
  end

  def is_amicable?
    partner = sum_proper_divisors
    partner != self && partner.sum_proper_divisors == self
  end
end