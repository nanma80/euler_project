require 'set'

def triangle_numbers(limit = 100)
  set = Set.new
  (1..limit).each do |n|
    set << n * (n + 1) / 2
  end
  set
end

def words
  filename = 'p042_words.txt'
  words = File.read(filename).split(',')
  words = words.map do |word|
    word[1..-2]
  end
  words
end

def value(char)
  char.ord - 'A'.ord + 1
end

def word_value(word)
  sum = 0
  word.split('').each do |char|
    sum += value(char)
  end
  sum
end

numbers = triangle_numbers
count = 0
words.each do |word|
  if numbers.include?(word_value(word))
    count += 1
  end
end

puts count
