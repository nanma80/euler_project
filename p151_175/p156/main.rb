require 'benchmark'

class DigitCounter
  def initialize(limit)
    @limit = limit
    @counts = [0] * 10
    @sum_of_solutions = 0
  end

  def get_sum
    solution_counter = 1
    (0..@limit).each do |i|
      i_string = i.to_s
      i_string.split('').map(&:to_i).each do |digit|
        @counts[digit] += 1
      end

      is_solution = false
      (1..9).each do |digit|
        if @counts[digit] == i
          puts "#{solution_counter} #{i} #{digit}"
          @sum_of_solutions += i
          is_solution = true
        end
      end

      if is_solution
        solution_counter += 1
      end
    end
    @sum_of_solutions
  end
end

def main
  limit = 10 ** 6
  digit_counter = DigitCounter.new(limit)
  puts digit_counter.get_sum
end

puts Benchmark.measure { main }