class Animal:
  name = ""
  def __init__(self, name):
    self.name = name
  def getName(self):
    print(self.name)

obj = Animal("cat")

obj.getName()