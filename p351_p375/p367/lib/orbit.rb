require '../../common'

class Orbit
  attr_reader :orbit_structure

  def initialize(orbit_structure)
    @orbit_structure = orbit_structure
  end

  def ==(that)
    @orbit_structure == that.orbit_structure
  end

  def sample_perm
    output = []
    orbit_structure.each do |period|
      content = ((output.length)..(output.length + period - 1)).to_a
      output += (content[1..-1] + content[0..0])
    end
    Permutation.new(output)
  end

  def neighbors
    return @neighbors unless @neighbors.nil?

    @neighbors = {}
    before_dedup = sample_perm.neighbors.map(&:orbit)
    before_dedup.each do |orbit|
      key = orbit.to_a
      @neighbors[key] = (@neighbors[key] || 0) + 1
    end
    @neighbors
  end

  def to_a
    @orbit_structure
  end

  def weight
    # number of permutations with this orbit structure
    return @weight unless @weight.nil?

    sum = orbit_structure.inject(:+)
    @weight = sum.factorial
    orbit_structure.each do |count|
      @weight /= count
    end

    orbit_structure.uniq.each do |uniq_period|
      @weight /= orbit_structure.count(uniq_period).factorial
    end

    @weight
  end

  class << self
    def each(element_count, upper_bound)
      if element_count < 1
        yield []
      else
        (1..[element_count, upper_bound].min).each do |start|
          each(element_count - start, start) do |suffix|
            yield [start] + suffix
          end
        end
      end
    end

    def each_orbit(element_count)
      each(element_count, element_count) do |orbit_array|
        yield Orbit.new(orbit_array)
      end
    end

    def all(element_count)
      all = []
      each_orbit(element_count) do |orbit|
        all << orbit
      end
      all
    end
  end
end
