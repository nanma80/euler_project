y0 = 100.0
v0 = 20.0
g = 9.81

a = (v0 ** 4) / (g * g) + 2 * v0 * v0 * y0 / g
b = 2 * v0 * v0 / g
y_max = y0 + v0 * v0 / (2.0 * g)
volume = Math::PI * (a * y_max - 0.5 * b * y_max * y_max)

p volume