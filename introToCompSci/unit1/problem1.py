s = 'azcbobobegghakl'
vowel = 'aiueo'
letterCount = 0

for letter in s:
  if letter in vowel:
    letterCount += 1
print("Number of vowels:", letterCount)