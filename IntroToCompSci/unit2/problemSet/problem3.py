balance = 320000
annualInterestRate = 0.2
monthlyInterestRate = annualInterestRate/12
l = balance/12
r = balance*((1+monthlyInterestRate)**12)/12
minPay = balance
while round(l, 2)<round(r, 2):
  payment = l+(r-l)/2
  tempBal = balance
  for i in range(12):
    tempBal -= payment
    tempBal += tempBal * monthlyInterestRate
  if tempBal > 0: l = payment
  else:
    r = payment
    minPay = min(minPay, payment)

print("Lowest Payment: %.2f" % minPay)