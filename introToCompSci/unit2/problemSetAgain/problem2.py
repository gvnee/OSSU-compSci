balance = 4773
annualInterestRate = 0.2

lowest = 10
while True:
  currentBal = balance
  for month in range(12):
    currentBal -= lowest
    currentBal += (annualInterestRate / 12) * currentBal
  if currentBal <= 0: break
  lowest += 10


print("Lowest Payment:", lowest)