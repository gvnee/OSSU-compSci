def isIn(char, aStr):
  l = 0
  r = len(aStr) - 1
  while(l<r):
    mid = int(l+(r-l)/2)
    if char == aStr[mid]:
      return True
    elif char > aStr[mid]:
      l = mid
    else:
      r = mid
  return False

print(isIn('z', 'abcdefgh'))
