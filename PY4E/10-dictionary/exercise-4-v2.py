file = open("mbox-short.txt")
dic = dict()
mostMail = 0
mostMailSender = ''
for line in file:
  if line.startswith("From "):
    sender = line.split()[1]
    dic[sender] = dic.get(sender, 0) + 1

for key, value in dic.items():
  if value > mostMail:
    mostMail = value
    mostMailSender = key

print(mostMailSender, mostMail)