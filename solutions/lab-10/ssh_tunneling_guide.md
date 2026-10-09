# Local Port Forwarding
```bash
ssh -L 8088:localhost:80 mohammad@192.0.2.10
```
Client port 8088 forwards to port 80 as seen from the SSH server.
Use case: access a web service that listens only on server localhost.
After creating the tunnel, request http://localhost:8088 on the client.

# Remote Port Forwarding
```bash
ssh -R 9000:localhost:3000 mohammad@192.0.2.10
```
Server port 9000 forwards to port 3000 as seen from the SSH client.
Use case: let the server access a development application on a laptop.
By default, this remote listener is bound to server loopback.

# Dynamic Port Forwarding
```bash
ssh -D 1080 mohammad@192.0.2.10
curl --socks5-hostname localhost:1080 https://example.com
```
A SOCKS proxy is created on the client; the application chooses each destination.
Use case: test access through the SSH server network path.

Add -N when no remote command is needed.
The recorded local test used HTTP destination port 8080, local listener 8088, remote listener 9000,
and SOCKS listener 1080. Results are in ssh_lab_test.txt.
The test client and sshd ran as separate processes on the same machine.
