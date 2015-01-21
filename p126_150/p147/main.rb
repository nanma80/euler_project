class Agent
  def initialize
    @cross_cache = {}
  end

  def right_rectangle_count(m, n)
    m * (m + 1) * n * (n + 1) / 4
  end

  def cross_rectangle_count(m, n)
    if m < n
      return cross_rectangle_count(n, m)
    end

    [[n, n], [n + 1, n]].each do |to_compute|
      if @cross_cache[to_compute].nil?
        @cross_cache[to_compute] = compute_cross_rectangle_count(to_compute[0], to_compute[1])
      end
    end

    start_count = @cross_cache[[n, n]]
    increased_count = @cross_cache[[n + 1, n]]
    
    start_count + (m - n) * (increased_count - start_count)
  end

  def compute_cross_rectangle_count(m, n)
    count = 0
    upper_limit = m + n - 2
    (1..upper_limit).each do |x_start|
      (x_start..upper_limit).each do |x_stop|
        (1..upper_limit).each do |y_start|
          (y_start..upper_limit).each do |y_stop|
            break if x_start + y_start < n
            break if (upper_limit - x_stop + 1) + (upper_limit - y_stop + 1) < n
            break if x_start + (upper_limit - y_stop + 1) < m
            break if (upper_limit - x_stop + 1) + y_start < m
            count += 1
          end
        end    
      end
    end

    count
  end

  def count(m, n)
    right_rectangle_count(m, n) + cross_rectangle_count(m, n)
  end

  def count_up_to(m_limit, n_limit)
    total = 0
    (1..m_limit).each do |m|
      (1..n_limit).each do |n|
        total += count(m, n)
      end
    end
    total
  end
end


agent = Agent.new
p agent.count_up_to(47, 43)
