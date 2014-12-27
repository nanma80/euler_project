class Factorial
  def factorials
    return @factorials unless @factorials.nil?
    puts 'Computing'
    @factorials = [1]
    (1..9).each do |n|
      @factorials << @factorials.last * n
    end
    @factorials
  end

  def digit_factorial_sum(n)
    n.to_s.split('').map do |char|
      factorials[char.to_i]
    end.inject(:+)
  end
end

limit = 10 ** 6
steps = {}
steps[169] = 3
steps[363601] = 3
steps[1454] = 3
steps[871] = 2
steps[45361] = 2
steps[872] = 2
steps[45362] = 2

count_60 = 0
factorials = Factorial.new

(1..limit).each do |start_number|
  puts start_number if start_number % (10 ** 4) == 0

  n = start_number
  path = []
  while steps[n].nil?
    path << n
    new_n = factorials.digit_factorial_sum(n)
    if new_n == n
      steps[n] = 1
      path = []
      break
    else
      n = new_n
    end
  end
  end_steps = steps[n]
  path_length = path.length
  path.each_with_index do |k, index|
    steps[k] = end_steps + path_length - index

    if steps[k] == 60
      puts "#{k}: 60"
      count_60 += 1
    elsif steps[k] > 60
      raise "#{k}: #{steps[k]}"
    end
  end
end

p count_60

# 402