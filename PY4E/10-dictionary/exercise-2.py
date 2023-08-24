file = open("mbox-short.txt")
dic = dict()
for line in file:
  if line.startswith("From "):
    day = line.split()[2]
    dic[day] = dic.get(day, 0) + 1
print(dic)