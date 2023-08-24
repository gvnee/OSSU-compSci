res, cur = '', ''
prev = 'a'
for l in s:
  if l >= prev: cur+=l
  else: cur = l
  if len(cur) > len(res): res = cur
  prev = l
print("Longest substring in alphabetical order is:", res)