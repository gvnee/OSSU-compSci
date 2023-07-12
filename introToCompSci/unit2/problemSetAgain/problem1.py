balance = 42
annualInterestRate = 0.2
monthlyInterestRate = annualInterestRate / 12
monthlyPaymentRate = 0.04

for month in range(12):
  balance -= monthlyPaymentRate * balance
  balance += monthlyInterestRate * balance
print("Remaining balance: %.2f" % balance)