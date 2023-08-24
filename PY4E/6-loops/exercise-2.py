largest = None
smol = None
while True:
  try:
    number = input("Enter a number: ")
    if number == "done":
      break
    else:
      number = int(number)
      if largest is None:
        largest = number
      else:
        largest = max(largest, number)
      if smol is None:
        smol = number
      else:
        smol = min(smol, number)
  except:
    print("Invalid input")
    continue

print("Maximum is", largest)
print("Minimum is", smol)