class Board
  attr_reader :limit, :coordinates_to_value, :value_to_coordinates

  def initialize(limit)
    @limit = limit
    @prime_cache = Prime::Cache.new(limit)
    @coordinates_to_value = {}
    @value_to_coordinates = {}
    initialize_board
  end

  def board
    @coordinates_to_value
  end

  def initialize_board
    counter = 1
    each_coordinates do |coord|
      @coordinates_to_value[coord] = counter
      @value_to_coordinates[counter] = coord
      counter += 1
    end
  end

  def each_coordinates
    yield [0, 0]
    counter = 1
    return if counter == limit

    (1..limit).each do |layer|
      curr_coord = [0, layer]
      curr_dir = [-1, -1]

      6.times do
        layer.times do 
          yield curr_coord
          counter += 1
          return if counter == limit
          curr_coord = [curr_coord, curr_dir].transpose.map do |arr|
            arr.inject(:+)
          end
        end
        curr_dir = next_direction(curr_dir)
      end
    end
  end

  def neighbors(value)
    coordinates = @value_to_coordinates[value]
    output = []
    all_directions.each do |direction|
      neighbor_coordinates = [coordinates, direction].transpose.map do |arr|
        arr.inject(:+)
      end

      output << @coordinates_to_value[neighbor_coordinates]
    end
    output
  end

  def neighbor_diffs(value)
    neighbors(value).map do |neighbor_value|
      if neighbor_value.nil?
        nil
      else
        (neighbor_value - value).abs
      end
    end
  end

  def prime_count(value)
    count = 0
    neighbor_diffs(value).each do |diff|
      next if diff.nil?
      if @prime_cache.is_prime?(diff)
        count += 1
      end
    end
    count
  end

  def all_directions
    @all_directions ||= [[-1, 0], [-1, -1], [0, -1], [1, 0], [1, 1], [0, 1]]
  end

  def next_direction(current_direction)
    curr_index = all_directions.index(current_direction)
    new_index = (curr_index + 1) % 6
    all_directions[new_index]
  end
end
