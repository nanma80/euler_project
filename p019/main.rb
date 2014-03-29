require 'date'

date = DateTime.new(1901, 1, 1)
number_of_sundays = 0


until date.year == 2000 && date.mon == 12 && date.mday == 31
  number_of_sundays += 1 if date.mday == 1 and date.wday == 0
  date += 1
end

puts number_of_sundays

