up = 1
down = 1
count = 0

1000.times do |index|
  up += down # + 1
  up, down = down, up # 1/x
  up += down # + 1
  if up.to_s.length > down.to_s.length
    count += 1
  end
end

p count