require 'pp'

def anagrams(words)
  word_anagrams = {}

  words.each do |word|
    key = word.split('').sort.join
    word_anagrams[key] = (word_anagrams[key] || []) + [word]
  end

  output = []
  word_anagrams.each do |key, anagramatic_words|
    output << anagramatic_words if anagramatic_words.length > 1
  end

  output.sort_by do |word_array|
    - word_array.first.length
  end
end

def pairs(array)
  output = []
  array.each_with_index do |word, index_1|
    (0..(array.length - 1)).each do |index_2|
      next if index_2 == index_1
      output << [word, array[index_2]]
    end
  end
  output
end

def mapping(word, number)
  mapping = {}
  reverse_mapping = {}

  (0..(word.length - 1)).each do |i|
    char = word[i]
    digit = number[i]
    if mapping[char].nil?
      mapping[char] = digit
    elsif mapping[char] != digit
      return nil # inconsistent mapping
    end

    if reverse_mapping[digit].nil?
      reverse_mapping[digit] = char
    elsif reverse_mapping[digit] != char
      return nil
    end
  end
  mapping
end

def apply_mapping(mapping, word)
  word.split('').map do |char|
    mapping[char]
  end.join
end

words_file = 'p098_words.txt'

words = File.read(words_file).split(',').map{|str| str[1..-2]}

numbers = []
(1..(10**5)).each do |n|
  number_string = (n ** 2).to_s
  numbers << number_string if number_string.length <= 9
end

anagramic_numbers = anagrams(numbers)
anagramic_words = anagrams(words)

largest_number = 0

anagramic_words.each do |anagram|
  word_length = anagram.first.length

  anagramic_numbers.each do |numbers_array|
    next if numbers_array.first.length != word_length
    pairs(numbers_array).each do |pair|
      map = mapping(anagram.first, pair.first)
      next if map.nil?
      if apply_mapping(map, anagram.last) == pair.last
        # p [anagram, pair]
        larger = pair.map(&:to_i).max
        if largest_number < larger
          largest_number = larger
        end
      end
    end
  end
end

p largest_number