def gcdRecur(a, b):
  if a == 0:
    return b
  elif b == 0:
    return a
  if a>b:
    return gcdRecur(a%b, b)
  else:
    return gcdRecur(a, b%a)