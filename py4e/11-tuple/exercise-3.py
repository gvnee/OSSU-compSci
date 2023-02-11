import string
file = open("mbox-short.txt")
dic = dict()

for line in file:
  words = line.lower().split()
  for word in words:
    for letter in word:
      if letter not in string.punctuation:
        dic[letter] = dic.get(letter, 0) + 1

temp = list()

for letter, count in dic.items():
  temp.append( (count, letter) )
temp.sort(reverse=True)
for letter, count in temp:
  print(letter, count)