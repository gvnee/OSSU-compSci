total = 0
count = 0
average = 0
while True:
  try:
    number = input("Enter a number: ")
    if number == "done":
      break
    else:
      number = int(number)
      count += 1
      total += number
  except:
    print("Invalid input")
    continue

average = float(total / count)
print(total, count, average)