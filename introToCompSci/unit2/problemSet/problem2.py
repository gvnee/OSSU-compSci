balance = 3329
annualInterestRate = 0.2
monthlyInterest = annualInterestRate/12
fixedPayment = 0
while True:
  fixedPayment += 10
  tempBal = balance
  for month in range(1, 13):
    tempBal -= fixedPayment
    tempBal += tempBal*monthlyInterest
  if tempBal <= 0:
    print("Lowest Payment: %d" % fixedPayment)
    break
