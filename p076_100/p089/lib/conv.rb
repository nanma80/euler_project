class Conv
  def mapping_to_roman
    {
      1 => 'I',
      5 => 'V',
      10 => 'X',
      50 => 'L',
      100 => 'C',
      500 => 'D',
      1000 => 'M'
    }
  end

  def filter_to_roman
    [
      [1000, 'M'],
      [900, 'CM'],
      [500, 'D'],
      [400, 'CD'],
      [100, 'C'],
      [90, 'XC'],
      [50, 'L'],
      [40, 'XL'],
      [10, 'X'],
      [9, 'IX'],
      [5, 'V'],
      [4, 'IV'],
      [1, 'I']
    ]
  end

  def mapping_to_int
    return @mapping_to_int unless @mapping_to_int.nil?
    @mapping_to_int = {}
    mapping_to_roman.each do |int, roman|
      @mapping_to_int[roman] = int
    end
    @mapping_to_int
  end

  def to_int(string)
    numbers = to_numbers(string)
    (numbers.length - 1).times do |index|
      if numbers[index] < numbers[index + 1]
        numbers[index + 1] = numbers[index + 1] - numbers[index]
        numbers[index] = 0
      end
    end
    numbers.inject(:+)
  end

  def to_numbers(string)
    string.split('').map do |char|
      mapping_to_int[char]
    end
  end

  def to_roman(int)
    return '' if int == 0

    filter_to_roman.each do |rule|
      if int >= rule.first
        return rule.last + to_roman(int - rule.first)
      end
    end
  end
end