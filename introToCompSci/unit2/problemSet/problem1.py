balance = 42.0
annualInterestRate = 0.2
monthlyPaymentRate = 0.04
monthlyInterestRate = annualInterestRate/12.0

for month in range(1, 13):
  balance -= balance * monthlyPaymentRate
  balance += balance * monthlyInterestRate
  # print("Month %d Remaining balance: %.2f" % (month, balance))
print("Remaining balance: %.2f" % balance)