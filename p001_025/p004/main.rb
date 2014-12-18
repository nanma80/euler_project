MAX = 999
MIN = 900

def is_palindrome?(number)
  number.to_s.reverse == number.to_s
end

max_palindrome = 0

MAX.downto(MIN) do |i|
  MAX.downto(MIN) do |j|
    n = i * j
    if n > max_palindrome && is_palindrome?(n)
      max_palindrome = n
    end
  end
end

puts max_palindrome # 906609

# puts is_palindrome?(9)
# puts is_palindrome?(91)
# puts is_palindrome?(945)