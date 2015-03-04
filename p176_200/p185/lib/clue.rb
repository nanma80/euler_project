class Clue
  attr_reader :guess, :correct, :length

  def initialize(string)
    array = string.split(' ')
    @guess = array[0].split('').map(&:to_i)
    @correct = array[1][1..-1].to_i
    @length = @guess.length
  end

  def each_filter
    (0..length - 1).to_a.combination(correct) do |comb|
      filter = [false] * length
      comb.each do |i|
        filter[i] = true
      end
      yield filter
    end
  end
end
