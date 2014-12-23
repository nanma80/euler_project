# password = 'god'

def decipher(ciphers, password)
  password_length = password.length
  password_int = password.map(&:ord)
  text = ''
  ciphers.each_with_index do |cipher, index|
    decipher_int = cipher ^ password_int[index % password_length]
    text << decipher_int.chr
  end
  text
end

def try(ciphers)
  lower_case_chars = ('a'..'z')
  lower_case_chars.each do |a|
    lower_case_chars.each do |b|
      lower_case_chars.each do |c|
        password = [a, b, c]
        text = decipher(ciphers, password)
        
        if text.downcase.include?('the ')
          puts text
          puts '***********'
          puts password.join
        end
      end
    end
  end
end

def sum_ascii(text)
  sum = 0
  text.split('').each do |c|
    sum += c.ord
  end
  sum
end

filename = 'p059_cipher.txt'
ciphers = File.read(filename).split(',').map(&:to_i)
# try(ciphers) # found the password: god

puts sum_ascii(decipher(ciphers, 'god'.split('')))

