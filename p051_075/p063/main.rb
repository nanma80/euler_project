count = 0
(1..30).each do |exponent|
  (1..20).each do |base|
    power_length = (base ** exponent).to_s.length
    if power_length == exponent
      count += 1
    elsif power_length > exponent
      break
    end
  end
end

p count