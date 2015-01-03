require 'pp'

def anagrams(words)
  word_anagrams = {}

  words.each do |word|
    key = word.split('').sort.join
    word_anagrams[key] = (word_anagrams[key] || []) + [word]
  end

  output = []
  word_anagrams.each do |key, words|
    output << words if words.length > 1
  end

  output.sort_by do |word_array|
    - word_array.first.length
  end
end

words_file = 'p098_words.txt'

words = File.read(words_file).split(',').map{|str| str[1..-2]}


numbers = []
(1..(10**5)).each do |n|
  number_string = (n ** 2).to_s
  numbers << number_string if number_string.length <= 9
end
pp anagrams(numbers)
pp anagrams(words)