# Observe that 1777 ** (10 ** 8) == 1 mod 10 ** 8

require '../../common'


mod = 10 ** 8
hyp_exp = 1855

current = 1777
(hyp_exp - 1).times do
  current = current % mod
  current = 1777.mod_pow(current, mod)
end
p current