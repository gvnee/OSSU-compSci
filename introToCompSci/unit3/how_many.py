def how_many(aDict):
  count = 0
  for item in aDict.values():
    count+=len(item)
  return count
animals = { 'a': ['aardvark'], 'b': ['baboon'], 'c': ['coati']}
animals['d'] = ['donkey']
animals['d'].append('dog')
animals['d'].append('dingo')
print(animals)
print(type(animals['d']))
print(how_many(animals))