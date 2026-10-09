import http.server
import socketserver
import os

PORT = 8080
os.chdir('public')
Handler = http.server.SimpleHTTPRequestHandler
with socketserver.TCPServer(('localhost', PORT), Handler) as httpd:
    print(f'Server at http://localhost:{PORT}', flush=True)
    httpd.serve_forever()
