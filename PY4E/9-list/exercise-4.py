file = open("romeo.txt")

words = list()

for line in file:
  for word in line.split():
    if word not in words:
      words.append(word)

words.sort()
print(words)