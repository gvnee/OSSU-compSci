import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

url = input("enter URL: ")
domain = url.split('/')[2]
try:
  sock.connect((domain, 80))
except:
  print("wrong input")
  quit()

cmd = 'GET ' + url + ' HTTP/1.0\r\n\r\n'
cmd = cmd.encode()
sock.send(cmd)

while True:
  data = sock.recv(512)
  if len(data) < 1:
    break
  print(data.decode())
sock.close()