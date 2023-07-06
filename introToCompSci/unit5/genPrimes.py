def genPrimes():
  i = 1
  primes = []
  while True:
    isPrime = True
    i += 1
    for prime in primes:
      if i % prime == 0:
        isPrime = False
        break
    if isPrime:
      primes.append(i)
      yield i
gen = genPrimes()
print(gen.__next__())
print(gen.__next__())
print(gen.__next__())
print(gen.__next__())
print(gen.__next__())