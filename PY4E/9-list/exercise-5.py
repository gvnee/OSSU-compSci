fileName = input("Enter a file name: ")
try:
  file = open(fileName)
except:
  print("invalid file name")
  quit()

count = 0
for line in file:
  if line.startswith("From "):
    count += 1
    print(line.split()[1])

if count == 0:
  print("There wasn't any line in the file with From ast he first word")
elif count == 1:
  print("There was 1 line in the file with FroM mas the first word")
else:
  print("There were", count, "lines in the file with From as the first word")