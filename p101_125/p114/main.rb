size = 50

after_red = [0]
after_black = [1]


(1..size).each do |k|
  after_black << (after_black[k - 1] + after_red[k - 1])

  new_after_red = 0
  (0..(k - 3)).each do |sub_k|
    new_after_red += after_black[sub_k]
  end
  after_red << new_after_red
end

p after_red[size] + after_black[size]