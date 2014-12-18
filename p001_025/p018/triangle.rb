class Triangle
  attr_reader :values, :max

  def initialize(filename)
    @values = []
    File.open(filename).each do |line|
      @values << line.chomp.split(' ').map {|number| number.to_i}
    end
    @max = nil
  end

  def max
    return @max unless @max.nil?

    @max = []
    values.each_with_index do |row, row_index|
      max_row = []
      row.each_with_index do |value, column_index|
        max_above = 0
        row_index_above = row_index - 1
        column_index_left = column_index - 1
        column_index_right = column_index

        if row_index_above >= 0 && column_index_left >= 0 && max[row_index_above][column_index_left] > max_above
          max_above = max[row_index_above][column_index_left]
        end

        if row_index_above >= 0 && column_index_right <= row_index_above && max[row_index_above][column_index_right] > max_above
          max_above = max[row_index_above][column_index_right]
        end

        max_row << max_above + value
      end
      @max << max_row
    end
    @max
  end

  def max_sum
    max[-1].max
  end
end
