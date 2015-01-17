require 'pp'

class Integer
  def sub_power
    output = []
    size = self / 2
    while size > 0
      output << size
      size /= 2
    end
    output
  end
end

class Path
  attr_reader :steps, :probability

  def initialize(steps, probability)
    @steps = steps
    @probability = probability
  end

  def add_probability(delta)
    @probability += delta
  end

  def completed?
    @steps.last == [1]
  end

  def single_sheet_count
    count = 0
    steps.each do |step|
      if step.length == 1 && step != [1]
        count += 1
      end
    end
    count
  end

  def each_extension
    raise if completed?
    last_step = steps.last
    probability_per_extension = probability / last_step.length
    last_step.each_with_index do |sheet, index|
      new_step = last_step.dup
      new_step.delete_at(index)
      new_step = (new_step + sheet.sub_power).sort.reverse
      yield Path.new(steps + [new_step], probability_per_extension)
    end
  end
end

# path = Path.new([[4, 2, 1]], 1.0)
# path.each_extension

class Agent
  attr_reader :start_size

  def initialize(start_size)
    @start_size = start_size
  end

  def path_head
    @path_head ||= Path.new([start_size.sub_power], 1.0)
  end

  def all_paths
    paths = {}
    paths[path_head.steps] = path_head

    until paths.values.first.completed?
      new_paths = {}
      paths.each do |steps, path_object|
        path_object.each_extension do |extension|
          new_steps = extension.steps

          if new_paths[new_steps].nil?
            new_paths[new_steps] = extension
          else
            new_paths[new_steps].add_probability(extension.probability)
          end
        end
      end
      paths = new_paths
    end
    paths
  end

  def expected_single_sheet_count
    paths = all_paths
    puts "Number of paths: #{paths.length}"
    expectation = 0.0
    paths.each do |steps, path_object|
      expectation += path_object.probability * path_object.single_sheet_count
    end
    expectation
  end
end

agent = Agent.new(16)
p agent.expected_single_sheet_count

# 0.4643987816010946
# 0.464399