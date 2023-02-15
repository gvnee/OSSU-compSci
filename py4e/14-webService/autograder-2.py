import urllib.request, urllib.parse, urllib.error
import json
import ssl

url = "http://py4e-data.dr-chuck.net/comments_1744897.json"

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

response = urllib.request.urlopen(url, context=ctx)
data = response.read()

info = json.loads(data)

total = 0
dic = info["comments"]
for obj in dic:
  # print(obj)
  total += obj["count"]
print(total)