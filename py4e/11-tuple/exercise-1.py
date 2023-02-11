file = open("mbox-short.txt")

dic = dict()
for line in file:
  if line.startswith("From "):
    line = line.rstrip()
    sender = line.split()[1]
    dic[sender] = dic.get(sender, 0) + 1

temp = list()

for key, value in dic.items():
  temp.append( (value, key) )

temp = sorted(temp, reverse=True)
print(temp[0][1], temp[0][0])