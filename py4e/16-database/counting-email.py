import sqlite3

conn = sqlite3.connect('emaildb.sqlite')
cur = conn.cursor()

cur.execute('DROP TABLE IF EXISTS Counts')

cur.execute('CREATE TABLE Counts(org TEXT, count INTEGER)')

file = open('mbox.txt')

for line in file:
  if line.startswith('From: '):
    pieces = line.split()
    org = pieces[1].split('@')[1]
    cur.execute('Select count FROM Counts WHERE org = ?', (org,))
    row = cur.fetchone()
    if row is None:
      cur.execute('INSERT INTO Counts (org, count) VALUES (?, 1)', (org,))
    else:
      cur.execute('UPDATE Counts SET count = count + 1 WHERE org = ?', (org,))

conn.commit()
sqlstr = 'SELECT org, count FROM Counts ORDER BY count DESC LIMIT 10'

for row in cur.execute(sqlstr):
  print(str(row[0]), row[1])

cur.close()