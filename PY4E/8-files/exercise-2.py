fileName = input("Enter a file name: ")
try:
  file = open(fileName)
except:
  print("invalid file name")
  quit()

total = 0
count = 0

for line in file:
  line = line.rstrip()
  if line.startswith("X-DSPAM-Confidence:"):
    count += 1
    colonLoc = line.find(':')
    total += float(line[colonLoc+1:])

average = float(total / count)

print("Average spam confidence:", average)