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
