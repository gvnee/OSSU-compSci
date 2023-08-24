def oddTuples(aTup):
  newTuple = ()
  for item in aTup[::2]:
    newTuple += (item,)
  return newTuple
# print(oddTuples(('I', 'am', 'a', 'test', 'tuple')))