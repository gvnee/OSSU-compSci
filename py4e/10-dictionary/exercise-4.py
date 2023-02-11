file = open("mbox-short.txt")
dic = dict()
mostMail = 0
mostMailSender = ''
for line in file:
  if line.startswith("From "):
    sender = line.split()[1]
    if dic.get(sender, 0) + 1 > mostMail:
      mostMail = dic.get(sender, 0) + 1
      mostMailSender = sender
    dic[sender] = dic.get(sender, 0) + 1
print(mostMailSender, mostMail)