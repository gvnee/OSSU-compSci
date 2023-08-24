def biggest(aDict):
  biggest = ''
  biggestLen = -1
  for key in aDict.keys():
    if len(aDict[key]) > biggestLen:
      biggest = key
      biggestLen = len(aDict[key])
  return biggest
# animals = { 'a': ['aardvark'], 'b': ['baboon'], 'c': ['coati']}

# animals['d'] = ['donkey']
# animals['d'].append('dog')
# animals['d'].append('dingo')
# print(biggest(animals))