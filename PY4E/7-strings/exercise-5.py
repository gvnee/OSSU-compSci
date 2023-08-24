text = "X-DSPAM-Confidence:    0.8475"
colonLocation = text.find(':')
str = text[colonLocation+1:]
str = str.strip()
number = float(str)
print(number)