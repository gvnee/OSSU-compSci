file = open("mbox-short.txt")
dic = dict()
for line in file:
  if line.startswith("From "):
    date = line.split()[5]
    hour = date.split(":")[0]
    dic[hour] = dic.get(hour, 0) + 1

temp = list()
for key, value in dic.items():
  temp.append( (key, value) )

temp.sort()

for key, value in temp:
  print(key, value)