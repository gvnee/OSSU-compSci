res, cur = '', ''
for i in range(len(s)):
  if i != 0 and s[i] >= s[i-1]: cur+=s[i]
  else: cur = s[i]
  if len(cur) > len(res): res = cur
print("Longest substring in alphabetical order is:", res)