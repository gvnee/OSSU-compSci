file = open("mbox-short.txt")
dic = dict()
for line in file:
  if line.startswith("From "):
    sender = line.split()[1]
    dic[sender] = dic.get(sender, 0) + 1
print(dic)