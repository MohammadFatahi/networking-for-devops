import socket
import time

server = socket.socket()
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('localhost', 2299))
server.listen(1)
print('TCP port 2299 is open, but no SSH banner is sent.', flush=True)
connection, address = server.accept()
time.sleep(10)
connection.close()
server.close()
