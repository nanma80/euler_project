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
    @orbit ||= Orbit.new(orbit_structure)
  end

  def ==(that)
    array == that.array
  end

  def neighbors
    neighbors_triple
  end

  def neighbors_triple
    output = []
    state = array
    state.length.times do |i|
      state.length.times do |j|
        break if j >= i
        state.length.times do |k|
          break if k >= j
          [i, j, k].permutation do |perm|
            new_state = state.dup
            new_state[i], new_state[j], new_state[k] = new_state[perm[0]], new_state[perm[1]], new_state[perm[2]]
            output << Permutation.new(new_state)
          end
        end
      end
    end
    output
  end

  def neighbors_pair
    []
  end
end