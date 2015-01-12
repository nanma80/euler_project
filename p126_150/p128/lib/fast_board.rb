class FastBoard
  attr_reader :limit

  def initialize(limit)
    @limit = limit
    @prime_cache = Prime::Cache.new(limit * 12 + 6)
  end

  def all_prime?(array)
    array.each do |n|
      if !(@prime_cache.is_prime?(n))
        return false
      end
    end
    true
  end

  def neighbors_start_of_layer(layer)
    diffs = [
      6 * layer - 1,
      6 * layer + 1,
      6 * layer + 6 * (layer + 1) - 1
    ]
    value = 2 + 6 * layer * (layer - 1) / 2
    return value, diffs
  end

  def neighbors_end_of_layer(layer)
    diffs = [
      6 * layer - 1,
      6 * (layer + 1) - 1,
      6 * layer + 6 * (layer - 1) - 1
    ]
    value = 1 + 6 * layer * (layer + 1) / 2
    return value, diffs
  end

  def values
    output = [1, 2]
    (2..limit).each do |layer|
      value, diffs = neighbors_start_of_layer(layer)
      output << value if all_prime?(diffs)

      value, diffs = neighbors_end_of_layer(layer)
      output << value if all_prime?(diffs)
    end

    output
  end
end