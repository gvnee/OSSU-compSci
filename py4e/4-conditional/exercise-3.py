score = float(input("Enter score: "))
if score < 0 or score > 1:
  print("Bad score")
elif score < 0.6:
  print("F")
elif score < 0.7:
  print("D")
elif score < 0.8:
  print("C")
elif score < 0.9:
  print("B")
else:
  print("A")