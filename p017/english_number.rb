class EnglishNumber
  attr_reader :value

  LESS_THAN_TWENTY = {
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen'
  }

  TENS = {
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninety'
  }

  HUNDRED = 'hundred'

  THOUSAND = 'one thousand'

  def initialize(value)
    @value = value
  end

  def name
    unless value >= 1 && value <= 1000 && (value.is_a? Integer)
      raise NotImplementedError.new "Unexpected number: #{value}"
    end

    if value < 20
      return LESS_THAN_TWENTY[value]
    end

    if (value % 10 == 0) && value >= 20 && value <= 90
      return TENS[value]
    end

    if value < 100
      low_digit = value % 10
      high_digit = value / 10
      return "#{EnglishNumber.new(high_digit * 10)}-#{EnglishNumber.new(low_digit)}"
    end

    if value == 1000
      return THOUSAND
    end

    if value % 100 == 0
      high_digit = value / 100
      return "#{EnglishNumber.new(high_digit)} #{HUNDRED}"
    end

    if value < 1000
      high_digit = value / 100
      lower_digits = value % 100
      return "#{EnglishNumber.new(high_digit * 100)} and #{EnglishNumber.new(lower_digits)}"
    end
  end

  def to_s
    name
  end

  def letter_count
    name.gsub(' ', '').gsub('-', '').length
  end
end
