fileName = input("Enter a file name: ")
if fileName == "na na boo boo":
  print("NA NA BOO BOO TO YOU - You have been punk'd!")
  quit()
try:
  file = open(fileName)
except:
  print("File cannot be opened:", fileName)
  quit()