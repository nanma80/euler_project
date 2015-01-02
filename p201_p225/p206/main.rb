# 1_2_3_4_5_6_7_8_9_0

# min: 1020304050607080900: 1010101010
# max: 1929394959697989990: 1389026623

min = 101010101
max = 138902662

(min..max).each do |k|
  sq = (k * k).to_s
  next if sq[0] != '1' || 
          sq[2] != '2' || 
          sq[4] != '3' || 
          sq[6] != '4' ||
          sq[8] != '5' ||
          sq[10] != '6' ||
          sq[12] != '7' ||
          sq[14] != '8' ||
          sq[16] != '9'
  puts k * 10
  puts sq.to_i * 100
  puts '1_2_3_4_5_6_7_8_9_0'
  exit
end