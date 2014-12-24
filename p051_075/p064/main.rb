class RootFraction
  attr_reader :base, :numerator, :denominator
  # Represents (Math.sqrt(base) + numerator)/denominator

  def initialize(base, numerator, denominator)
    @base = base
    @numerator = numerator
    @denominator = denominator
  end

  def ==(that)
    base == that.base && numerator == that.numerator && @denominator == that.denominator
  end

  def value
    @value ||= 1.0 * (Math.sqrt(base) + numerator)/denominator
  end

  def invert
    # denominator/(Math.sqrt(base) + numerator)
    # = denominator*(Math.sqrt(base) - numerator)/(Math.sqrt(base) + numerator)(Math.sqrt(base) - numerator)
    # = denominator*(Math.sqrt(base) - numerator)/(base - numerator ** 2)
    # = (Math.sqrt(base) - numerator)/((base - numerator ** 2)/denominator)
    if (base - numerator ** 2) % denominator != 0
      raise "Unexpected for base #{base}"
    end
    new_denominator = (base - numerator ** 2) / denominator
    new_numerator = - numerator
    RootFraction.new(base, new_numerator, new_denominator)
  end

  def separate
    whole_number = value.to_i
    [whole_number, RootFraction.new(base, numerator - denominator * whole_number, denominator)]
  end

  def to_s
    "(sqrt(#{base}) + (#{numerator}))/#{denominator}"
  end
end

def period_length(n = 23)
  fraction(n).last.length
end

def fraction(n = 23)
  a = RootFraction.new(n, 0, 1)
  if a.value == a.value.to_i
    return [a.value.to_i, []]
  end
  first_separate = a.separate
  whole_number = first_separate.first
  frac = first_separate.last
  sequence = []

  new_frac = nil
  until new_frac == frac
    new_separate = (new_frac || frac).invert.separate
    sequence << new_separate.first
    new_frac = new_separate.last
  end

  [whole_number, sequence]
end

count = 0
(2..10000).each do |n|
  count += 1 if period_length(n) % 2 == 1
end
p count

