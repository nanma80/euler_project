class Fraction
  attr_reader :num, :den

  def initialize(num, den)
    @num = num
    @den = den
  end

  def add(n)
    Fraction.new(num + n * den, den)
  end

  def invert
    Fraction.new(den, num)
  end

  def to_s
    "#{num}/#{den}"
  end

  def value
    1.0 * num / den
  end
end

def expanded_seq(seq, term_count)
  expanded = []
  while expanded.length < term_count
    expanded += seq.last
  end
  [seq.first, expanded[0..(term_count - 1)]]
end

def convergent(seq, term_count)
  frac = nil
  seq = expanded_seq(seq, term_count)
  seq.last.length.times do |index|
    number = seq.last[seq.last.length - index - 1]
    if frac.nil?
      frac = Fraction.new(number, 1)
    else
      frac = frac.invert.add(number)
    end
  end
  frac.invert.add(seq.first)
end

