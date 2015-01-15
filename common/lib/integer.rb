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

  def factorial
    return 0 if self < 0
    return 1 if self <= 1
    (1..self).inject(:*)
  end

  def choose(k)
    return 0 if k < 0 || k > self
    self.factorial / k.factorial / (self - k).factorial
  end

  def mod_pow(exponent, mod)
    binary = exponent.to_s(2).reverse.split('').map(&:to_i)
    output = 1
    powermod = self % mod
    binary.each do |bit|
      if bit == 1
        output = (output * powermod) % mod
      end

      powermod = (powermod * powermod) % mod
    end
    output
  end
end
