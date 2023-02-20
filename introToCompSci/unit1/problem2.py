s = 'azcbobobegghakl'
bobCount = 0
for i in range(len(s)):
  if s[i:i+3] == 'bob':
    bobCount += 1
print("Number of times bob occurs is:", bobCount)