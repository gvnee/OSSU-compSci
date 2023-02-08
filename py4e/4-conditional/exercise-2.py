try:
  hours = float(input("Enter Hours: "))
  rate = float(input("Enter Rate: "))
except:
  print("bad input")
  quit()
regularPayHours = 40
if hours > regularPayHours:
  pay = regularPayHours * rate
  pay += (hours - regularPayHours) * (rate * 1.5)
else:
  pay = hours * rate
print("Pay:", pay)
