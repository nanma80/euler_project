# Solutions are from Wolfram Alpha by searching
# "Integer solutions of 5x^2+14x+1=y^2, x>0, y>0"

def solutions(n)
  output = []
  output <<
  1.0/20.0 * (- 2.0 * 
    (
      -13.0 *(9 - 4* Math.sqrt(5.0))**(2.0*n+1) 
      + 5.0 * Math.sqrt(5.0) * (9-4*Math.sqrt(5))**(2*n+1) -
      13.0 *(9 + 4* Math.sqrt(5.0))**(2*n+1) -
      5.0 * Math.sqrt(5.0) * (9+4*Math.sqrt(5))**(2*n+1)
    )  - 28
  )

  output <<
  1.0/20 * (2.0 * 
    (
      13.0 *(9 - 4* Math.sqrt(5.0))**(2*n+1) +
      5.0 * Math.sqrt(5.0) * (9-4*Math.sqrt(5))**(2*n+1) +
      13.0 *(9 + 4* Math.sqrt(5.0))**(2*n+1) -
      5.0 * Math.sqrt(5.0) * (9+4*Math.sqrt(5))**(2*n+1)
    )  - 28
  )

  output <<
  1.0/20 * (- 4.0 * 
    (
      -4.0 *(9 - 4* Math.sqrt(5.0))**(2*n+1) +
      Math.sqrt(5.0) * (9-4*Math.sqrt(5))**(2*n+1) -
      4.0 *(9 + 4* Math.sqrt(5.0))**(2*n+1) -
      Math.sqrt(5.0) * (9+4*Math.sqrt(5))**(2*n+1)
    )  - 28
  )

  output <<
  1.0/20 * (4.0 * 
    (
      4.0 *(9 - 4* Math.sqrt(5.0))**(2*n+1) +
      Math.sqrt(5.0) * (9-4*Math.sqrt(5))**(2*n+1) +
      4.0 *(9 + 4* Math.sqrt(5.0))**(2*n+1) -
      Math.sqrt(5.0) * (9+4*Math.sqrt(5))**(2*n+1)
    )  - 28
  )

  output <<
  1.0/20 * (- 2.0 * 
    (
      -7.0 *(9 - 4* Math.sqrt(5.0))**(2*n) +
      Math.sqrt(5.0) * (9-4*Math.sqrt(5))**(2*n) -
      7.0 *(9 + 4* Math.sqrt(5.0))**(2*n) -
      Math.sqrt(5.0) * (9+4*Math.sqrt(5))**(2*n)
    )  - 28
  )

  output <<
  1.0/20 * (2.0 * 
    (
      7.0 *(9 - 4* Math.sqrt(5.0))**(2*n) +
      Math.sqrt(5.0) * (9-4*Math.sqrt(5))**(2*n) +
      7.0 *(9 + 4* Math.sqrt(5.0))**(2*n) -
      Math.sqrt(5.0) * (9+4*Math.sqrt(5))**(2*n)
    ) - 28
  )
end

combined = []
(0..5).each do |n|
  combined += solutions(n).map {|number| (number + 0.5).to_i }
  combined = combined.uniq.sort
end

combined.each_with_index do |n, i|
  puts "#{i}: #{n}" if n > 0
end

p combined[1..30].inject(:+)