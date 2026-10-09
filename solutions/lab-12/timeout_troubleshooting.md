# SSH connection timeout
|Possible cause|Diagnostic command|Proposed solution|
|---|---|---|
|Wrong IP or port|ssh -vvv -p 22 user@server; nc -zv -w 5 server 22|Verify the actual SSH address and port|
|Firewall silently drops packets|nc on the client; sudo ufw status on the server|Correct the rule for the intended address and port|
|Routing problem|ip route get SERVER_IP; tracepath SERVER_IP|Check gateway, routes, and VPN|
|Host down or SSH stopped|Server console; systemctl status ssh; ss -lntp|Start the host/service and inspect the listener|
|Name resolution fails|dig server; getent hosts server|Correct the name or resolver configuration|
|TCP connects but SSH does not respond|ssh -vvv -o ConnectTimeout=5 user@server|Check wrong-service port, server load, and sshd health|

Commands from the hint:
```bash
timeout 5 ssh user@server
telnet server 22
nc -zv -w 5 server 22
```
Connection refused normally means explicit rejection; timeout means a required response did not arrive in time.
Permission denied is an authentication error, distinct from a connection timeout.

Run the simulation from this directory:
```bash
bash timeout_test.sh
```
silent_server.py accepts TCP but does not send an SSH identification banner.
SSH times out waiting for identification. Recorded output is in timeout_simulation_report.txt.
This simulates an unresponsive protocol service without changing the system firewall.
