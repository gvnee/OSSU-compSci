def iterPower(base, exp):
  total = 1
  if exp == 0:
    return 1
  for i in range(exp):
    total *= base
  return total