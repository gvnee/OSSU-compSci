class intSet(object):
  def __init__(self):
    self.vals = []
  def insert(self, e):
    if not e in self.vals:
      self.vals.append(e)
  def member(self, e):
    return e in self.vals
  def remove(self, e):
    try:
      self.vals.remove(e)
    except:
      raise ValueError(str(e) + ' not found')
  def __str__(self):
    self.vals.sort()
    return '{' + ','.join([str(e) for e in self.vals]) + '}'
  def intersect(self, other):
    intersect = intSet()
    for i in self.vals:
      if i in other.vals:
        intersect.insert(i)
    return intersect
  def __len__(self):
    return len(self.vals)

set = intSet()
set.insert(2)
set.insert(3)
set.insert(5)
set2 = intSet()
set2.insert(0)
set2.insert(1)
print(set.intersect(set2))
print(set.vals)
print(set2.vals)
print(len(set))