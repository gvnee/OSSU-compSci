total = 0
count = 0
average = 0
numbers = list()
while True:
  try:
    number = input("Enter a number: ")
    if number == "done":
      break
    else:
      number = float(number)
      numbers.append(number)
  except:
    print("Invalid input")
    continue
print("Maximum:", max(numbers))
print("Minimum:", min(numbers))