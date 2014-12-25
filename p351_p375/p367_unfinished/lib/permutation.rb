class Permutation
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def orbit_structure
    visited = [false] * (array.length)
    output = []

    until (index = visited.index(false)).nil?
      visited[index] = true
      length = 1
      next_index = array[index]
      until visited[next_index]
        index = next_index
        visited[index] = true
        length += 1
        next_index = array[index]
      end
      output << length
    end
    output.sort_by {|n| -n }
  end

  def orbit
    Orbit.new(orbit_structure)
  end

  def ==(that)
    array == that.array
  end
end