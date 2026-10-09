import http.server
import ssl
import os

httpd = http.server.HTTPServer(('localhost', 8443), http.server.SimpleHTTPRequestHandler)
context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(certfile='certs/myapp.crt', keyfile='certs/myapp.key')
httpd.socket = context.wrap_socket(httpd.socket, server_side=True)
os.chdir('public')
print('Server running on https://localhost:8443', flush=True)
httpd.serve_forever()
