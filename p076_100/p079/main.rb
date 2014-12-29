filename = 'p079_keylog.txt'
tests = []
file = File.open(filename).each do |line|
  tests << line.chomp.split('')
end

tests = tests.uniq

['0', '1', '2', '3', '6', '7', '8', '9'].permutation do |perm|
  matched = true
  tests.each do |test|
    if perm.index(test[0]) > perm.index(test[1]) ||
      perm.index(test[1]) > perm.index(test[2])
      matched = false
      break
    end
  end
  if not matched
    next
  else
    puts perm.join
    exit
  end
end