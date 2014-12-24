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

def get_e_expansion(length)
  count = 2
  output = []
  while output.length < length
    output += [1, count, 1]
    count += 2
  end
  output[0..(length - 1)]
end

term_count = 100

seq_last = get_e_expansion(term_count - 1)
seq = [2, seq_last]
# seq = [1, [2, 2, 2, 2, 2, 2]]
frac = nil

seq.last.length.times do |index|
  number = seq.last[seq.last.length - index - 1]
  if frac.nil?
    frac = Fraction.new(number, 1)
  else
    frac = frac.invert.add(number)
  end
end
e_approx = frac.invert.add(seq.first)
p e_approx.num.to_s.split('').map(&:to_i).inject(0) {|mem, var| mem + var}
