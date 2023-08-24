from urllib.request import urlopen
from bs4 import BeautifulSoup
import ssl

def openUrl(url):
  html = urlopen(url, context=ctx).read()
  soup = BeautifulSoup(html, "html.parser")
  return soup

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = "http://py4e-data.dr-chuck.net/known_by_Caelinn.html"

soup = openUrl(url)

tags = soup('a')

for i in range(7):
  soup = openUrl(url)
  tags = soup('a')
  url = tags[17].get('href')
  print(url)