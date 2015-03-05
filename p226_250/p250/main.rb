require '../../common'

mod = 250
display_mod = 10 ** 16
subset_counts = [0] * mod
subset_counts[0] = 1

(1..250250).each do |k|
  n = k.mod_pow(k, mod)
  new_counts = [0] * mod
  mod.times do |new_remainder|
    old_remainder = (new_remainder - n) % mod
    new_counts[new_remainder] = (subset_counts[new_remainder] + subset_counts[old_remainder]) % display_mod
  end
  subset_counts = new_counts
end

puts subset_counts[0] - 1 # because non-empty
