annual_salary = float(input("Enter your annual salary: "))

portion_down_payment = 0.25 
semi_annual_raise = .07
total_cost = 1000000
r = 0.04 # annual return rate
monthly_r = r/12
need = total_cost * portion_down_payment
possible = True

n = 0
jump = 10000
iterations = 0
while True:
  jump /= 2
  iterations += 1
  current_savings = 0
  current_rate = n/10000
  temp_salary = annual_salary

  for month in range(1, 37):
    current_savings += (current_rate * temp_salary/12) + (current_savings * monthly_r)
    if month%6==0:
      temp_salary += temp_salary * semi_annual_raise

  if current_savings >= need - 100 and current_savings <= need + 100:
    break
  elif current_savings < need - 100:
    n += jump
  else: n -= jump

  if abs(float(10000) - n) <= 0.01:
    possible = False
    print("It is not possible to pay the down payment in three years.")
    break

if possible: print("Best savings rate:", n/10000)
print("Steps in bisection search:", iterations)