def isIn(char, aStr):
  mid = len(aStr)//2
  if aStr=='': return False
  if len(aStr) == 1:
    return aStr == char
  if char == aStr[mid]:
    return True
  elif char > aStr[mid]:
    return isIn(char, aStr[mid+1:])
  else:
    return isIn(char, aStr[:mid])