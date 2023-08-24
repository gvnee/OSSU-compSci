fileName = input("Enter a file name: ")
try:
  file = open(fileName)
except:
  print("invalid file name")
  quit()

for line in file:
  line = line.rstrip()
  line = line.upper()
  print(line)