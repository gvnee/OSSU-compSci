file = open("mbox-short.txt")
dic = dict()
for line in file:
  if line.startswith("From "):
    sender = line.split()[1]
    domain = sender.split('@')[1]
    dic[domain] = dic.get(domain, 0) + 1
print(dic)