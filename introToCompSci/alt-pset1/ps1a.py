annual_salary = float(input("Enter your annual salary: "))
portion_saved = float(input("Enter the percent of your salary to save, as a decimal: "))
total_cost = float(input("Enter the cost of your dream home: "))

portion_down_payment = 0.25 
r = 0.04 # annual return rate
current_savings = 0

monthly_salary = annual_salary/12
monthly_r = r/12
neededAmount = total_cost * portion_down_payment

month = 0

while current_savings < neededAmount:
  month += 1
  current_savings += (portion_saved * monthly_salary) + (current_savings * monthly_r)

print("Number of months:", month)