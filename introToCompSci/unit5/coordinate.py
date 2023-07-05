class Coordinate(object):
  def __init__(self, x, y):
    self.x = x
    self.y = y
  def getX(self):
    return self.x
  def getY(self):
    return self.y
  def __str__(self):
    return '<' + str(self.x) + ',' + str(self.y) + '>'
  def __eq__(self, other):
    return self.x == other.getX() and self.y == other.getY():
  def __repr__(self):
    x = str(self.x)
    y = str(self.y)
    return "Coordinate(" + x +',' + y + ')'

c = Coordinate(5, 5)
print(c)
b = Coordinate(5, 6)
d = Coordinate(5, 5)
print(c == b)
print(c == d)
print(repr(c))
print(eval(repr(c)) == c) 