# SSL and TLS
SSL is obsolete and has been superseded by TLS. HTTPS carries HTTP over TLS.

# Self-Signed and CA-Signed Certificates
A self-signed certificate is signed using its own corresponding key and is suitable for a local test.
A browser does not trust it by default. A CA-signed certificate chains to a trusted authority
and is generally more appropriate for a public website. Both can support encryption;
the important difference is trust in the server identity.

# Five TLS Practices
1. Disable obsolete SSL/TLS versions and use supported TLS 1.2 or 1.3.
2. Check the hostname, certificate chain, and expiration date.
3. Restrict access to the private key to the service that needs it.
4. Renew the certificate before expiration.
5. Use maintained, strong cipher configurations.

# HTTP and HTTPS Security
Ordinary HTTP does not encrypt data, allowing it to be read or changed along the path.
TLS encrypts data, authenticates the server through certificate verification, and detects
tampering. HTTPS does not replace fixing vulnerabilities in the application.

# Running the Lab Server
From the corresponding lab directory, run bash generate_ssl.sh and then python3 https_server.py.
In another terminal: curl -k https://localhost:8443
Stop the server with Ctrl+C.
Only the public directory is served so the private-key file cannot be downloaded through HTTP.

The original hint uses ssl.wrap_socket, which was removed in Python 3.12.
The supplied Python 3.14 server uses SSLContext.wrap_socket.
Source: https://docs.python.org/3.12/whatsnew/3.12.html#ssl
