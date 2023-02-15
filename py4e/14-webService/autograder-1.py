import urllib.request, urllib.parse, urllib.error
import xml.etree.ElementTree as et
import ssl

url = "http://py4e-data.dr-chuck.net/comments_1744896.xml"

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

response = urllib.request.urlopen(url, context=ctx)
data = response.read()

tree = et.fromstring(data.decode())

counts = tree.findall('.//count')
total = 0
for count in counts:
  total += int(count.text)

print(total)