s = 'azcbobobegghakl'

current = ""
previous = 'A'
longest = ""
for letter in s:
  if letter >= previous:
    current += letter;
  else:
    if(len(current)>len(longest)):
      longest = current
    current = letter
  previous = letter
if(len(current)>len(longest)):
  longest = current
print(longest)