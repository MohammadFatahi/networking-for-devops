# Unable to Reach example.com
|Stage|Diagnostic command|Possible cause|Proposed solution|
|---|---|---|---|
|1. Physical connection|ip -br link|Disconnected cable/Wi-Fi or DOWN interface|Inspect connection and enable the appropriate interface|
|2. Addressing|ip -br addr|Wrong address/subnet or failed DHCP|Correct addressing or inspect DHCP|
|3. DNS|dig example.com|Unavailable resolver or wrong record|Inspect resolver settings and domain records|
|4. Routing|ip route; ip route get 1.1.1.1|Incorrect default gateway or route|Correct gateway and routes|
|5. Firewall and port|nc -zv -w 5 example.com 443; sudo ufw status|Blocked port or stopped service|Inspect policy/service and allow the required access|
|6. Application and TLS|curl -vI --connect-timeout 5 --max-time 15 https://example.com|Certificate or HTTP error|Inspect certificate dates/hostname, URL, and application logs|

On a server for which administrative access is available:
```bash
ss -lntp
systemctl status nginx --no-pager
journalctl -u nginx -n 20 --no-pager
```
A failed ping alone does not prove that the website is down; ICMP may be filtered.
A DNS answer does not establish HTTP health either. Test each stage separately.
