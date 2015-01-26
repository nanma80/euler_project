require '../../common'

to_test = 30030
length = 100
x_values = [17, 19, 23, 29]

x_values.each do |k|
  residues = []
  (1..length).each do |n|
    residue = k.mod_pow(n, to_test)
    residues << residue
    break if residue == 1
  end
  # if residues.include? 1
    p [residues, residues.length]
  # end
end