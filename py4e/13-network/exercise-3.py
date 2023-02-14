import urllib.request, urllib.parse, urllib.error

url = input("enter URL: ")
try:
  fhand = urllib.request.urlopen(url)
except:
  print("invalid input")
  quit()

for line in fhand:
  print(line.decode().strip())