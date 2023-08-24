balance = 999999
annualInterestRate = 0.18
monthlyInterestRate = annualInterestRate / 12

lower = balance / 12
upper = balance * ((1 + monthlyInterestRate) ** 12) / 12
mid = 0
while lower < upper - 0.01:
  mid = lower + (upper - lower) / 2
  tempBal = balance
  for month in range(12):
    tempBal -= mid
    tempBal += monthlyInterestRate * tempBal
  if tempBal > 0: lower = mid
  else: upper = mid

print("Lowest Payment: %.2f" % mid)