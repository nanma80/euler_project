require File.expand_path('../integer', __FILE__)

def get_permutation(alphabet, n)
  # alphabet: sorted array
  # returns n-th smallest lexicographical permutation of the alphabet

  n -= 1
  raise RangeError if n > alphabet.length.factorial

  output = []

  while alphabet.length > 0
    subproblem_range = (alphabet.length - 1).factorial

    first_character = alphabet[n / subproblem_range]
    output << first_character
    alphabet.delete(first_character)
    n = n % subproblem_range
  end
  output  
end

puts get_permutation((0..9).collect(&:to_s), 1_000_000).join('')

