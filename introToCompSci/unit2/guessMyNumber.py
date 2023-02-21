print("Please think of a number between 0 and 100!")
l = 0
r = 100
while(True):
  mid = int(l + (r - l)/2)
  print("Is your secret number ", mid, "?")

  answer = input("Enter 'h' to indicate the guess is too high. Enter 'l' to indicate the guess is too low. Enter 'c' to indicate I guessed correctly.")
  if answer == 'c':
    print("Game over. Your secret number was:", mid)
    break
  elif answer == 'l': l = mid
  elif answer == 'h': r = mid
  else: print("Sorry, I did not understand your input.")