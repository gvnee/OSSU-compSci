def computepay(hours, rate):
  regularPayHours = 40
  if hours > regularPayHours:
    pay = regularPayHours * rate
    pay += (hours - regularPayHours) * (rate * 1.5)
  else:
    pay = hours * rate
  return pay

hours = float(input("Enter Hours: "))
rate = float(input("Enter Rate: "))
print("Pay", computepay(hours, rate))