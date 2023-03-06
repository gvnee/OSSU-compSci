def genPrimes():
  i = 1
  primes = []
  while True:
    notPrime = False
    i += 1
    for prime in primes:
      if i % prime == 0:
        notPrime = True
    if not notPrime:
      primes.append(i)
      yield i
gen = genPrimes()
print(gen.__next__())
print(gen.__next__())
print(gen.__next__())
print(gen.__next__())
print(gen.__next__())