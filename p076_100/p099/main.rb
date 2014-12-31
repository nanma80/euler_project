filename = 'p099_base_exp.txt'

max_log = 0
max_line_no = 0

File.open(filename).each_with_index do |line, index_0|
  line.chomp!
  pair = line.split(',').map(&:to_i)
  log = pair.last * Math.log(pair.first)
  if log > max_log
    max_log = log
    max_line_no = index_0 + 1
  end
end

p max_line_no