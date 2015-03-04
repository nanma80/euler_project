require 'set'

class Game
  attr_reader :clues, :length

  def initialize(filename)
    load_clues(filename)
  end

  def initial_possibilities
    possibilities = []
    length.times do
      possibilities << (0..9).to_a
    end
    possibilities
  end

  def load_clues(filename)
    @clues = []

    File.foreach(filename) do |line|
      line.chomp!
      @clues << Clue.new(line)
    end

    # @clues.sort_by! { |clue| (clue.correct == 0) ? (-100) : (-clue.correct) }
    # @clues.sort_by! { |clue| - clue.correct }
    # @clues.sort_by! { |clue| clue.correct }
    # @clues.sort_by! { |clue| (clue.correct == 0) ? (-100) : (Random.rand) }
    @clues.sort_by! do |clue|
      (clue.correct == 0) ? (-100) : ((clue.guess[0..2] == [2,3,2])? -99 : clue.correct)
    end
    @length = @clues.first.guess.length
  end

  def solve
    all_possibilities = Set.new([initial_possibilities])

    @clues.each_with_index do |clue, clue_index|
      p [clue_index, clue.correct, all_possibilities.length]
      new_all_possibilities = Set.new
      clue.each_filter do |filter|
        all_possibilities.each do |possibilities|
          outcome = outcome(possibilities, clue, filter)
          unless outcome.nil?
            new_all_possibilities << outcome
          end
        end
      end
      all_possibilities = new_all_possibilities
    end

    if all_possibilities.length != 1
      puts all_possibilities.inspect
      raise "all_possibilities.length is #{all_possibilities.length}"
    end

    all_possibilities.first.map {|a| a[0].to_s}.join
  end

  def outcome(possibilities, clue, filter)
    new_possibilities = []
    possibilities.each do |array|
      new_possibilities << array.dup
    end

    filter.each_with_index do |filter_boolean, index|
      clue_number = clue.guess[index]
      if filter_boolean
        if new_possibilities[index].include?(clue_number)
          new_possibilities[index] = [clue_number]
        else
          return nil
        end
      else
        new_possibilities[index].delete(clue_number)
        if new_possibilities[index].empty?
          return nil
        end
      end
    end
    new_possibilities
  end

  def likelihoods
    likelihoods = []
    length.times do
      likelihoods << Hash.new { |hash, key| hash[key] = 0 }
    end

    @clues.each do |clue|
      correct = clue.correct
      clue.guess.each_with_index do |number, index|
        likelihoods[index][number] += correct
      end
    end

    likelihoods
  end

  def top_likelihoods(ratio)
    sorted_likelihoods = likelihoods.map do |hash|
      hash.sort_by {|key, value| - value}
    end

    top_likelihoods = []
    sorted_likelihoods.each do |likelihood|
      max_value = likelihood[0][1]
      threshold = (ratio * max_value)
      top_likelihoods << likelihood.select {|arr| arr[1] >= threshold}.map {|arr| arr[0]}
    end

    top_likelihoods
  end

  def try_solve(ratio, start_index = 0)
    generator_limit = 1
    top_likelihoods = top_likelihoods(ratio)
    top_likelihoods.each do |guesses|
      generator_limit *= guesses.length
    end

    puts "Top likelihoods:"
    p top_likelihoods
    
    (start_index..generator_limit - 1).each do |generator|
      puts "#{generator}/#{generator_limit}" if generator % 100000 == 0
      indices = []
      top_likelihoods.each do |likelihood|
        indices << generator % likelihood.length
        generator /= likelihood.length
      end

      guess = []
      top_likelihoods.each_with_index do |likelihood, index|
        guess << likelihood[indices[index]]
      end

      if check(guess)
        return guess.map(&:to_s).join
      end
    end
    puts "not found"
  end

  def check(answer)
    @clues.each do |clue|
      correct = 0
      answer.each_with_index do |number, index|
        if number == clue.guess[index]
          correct += 1
        end
      end
      if correct != clue.correct
        return false
      end
    end
    true
  end

  def distance(answer)
    distance = 0
    @clues.each do |clue|
      correct = 0
      answer.each_with_index do |number, index|
        if number == clue.guess[index]
          correct += 1
        end
      end
      distance += (correct - clue.correct).abs
    end
    distance
  end

  def random_solve(keep_top_n)
    state = State.new(length)
    100000.times do |iteration|
      neighbor_distances = {}
      state.each_neighbor do |neighbor|
        neighbor_distances[neighbor] = distance(neighbor)
        if neighbor_distances[neighbor] == 0
          return neighbor.map(&:to_s).join
        end
      end
      
      sorted_distances = neighbor_distances.sort_by {|neighbor, distance| distance}[0..(keep_top_n - 1)]
      p sorted_distances if iteration % 100 == 0
      state.current = sorted_distances[rand(keep_top_n)].first
    end
    nil
  end
end