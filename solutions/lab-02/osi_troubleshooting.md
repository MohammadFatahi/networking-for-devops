# The OSI Model and Network Troubleshooting

The Open Systems Interconnection (OSI) model divides network communication into seven layers. It gives troubleshooting a structure: examine the lower layers first, then move upward to locate the stage at which communication fails.

## Layer 1 - Physical

This layer carries raw bits over Ethernet cables, optical fiber, or wireless links. Check the cable and connectors, link LEDs, whether the network adapter is enabled, and whether a physical connection exists.

```bash
ip link
ethtool enp1s0
```

`ip link` shows interface state; inspect whether the relevant interface is UP or DOWN. For an Ethernet adapter, `ethtool` shows physical-link details. `Link detected: yes` indicates carrier detection.

## Layer 2 - Data Link

This layer supports communication within the local segment. Relevant concepts include MAC addresses, Ethernet frames, switches, and ARP. Check the adapter MAC address, neighbor/ARP table, local connectivity, interface state, and the mapping between the local next-hop IP address and its MAC address.

```bash
ip link
ip neigh
```

The first command also displays interface MAC addresses. The second displays neighbor information and helps inspect IPv4 ARP mappings. For a remote destination, ARP normally resolves the local gateway rather than the remote server.

## Layer 3 - Network

This layer handles IP addressing and routing between networks. Check the assigned address, subnet prefix, default gateway, routing table, destination reachability, and path.

```bash
ip addr
ip route
ping 8.8.8.8
traceroute 8.8.8.8
```

`ip addr` displays assigned addresses. `ip route` displays routes and the default gateway. Ping tests ICMP reachability and round-trip timing. Traceroute probes routers along the path and can help investigate routing problems. Filtering or rate limiting can prevent diagnostic replies without preventing application traffic.

## Layer 4 - Transport

TCP and UDP provide transport between applications. Check the protocol, listening socket, connection state, and whether the destination port is reachable from the client.

```bash
ss -tuln
ss -ltn '( sport = :80 )'
nc -zv 192.168.1.10 80
```

The first command displays listening TCP sockets and UDP endpoints. The second checks the exact HTTP port. Netcat tests whether the client can establish a connection to the target port. A listener is not proof of an application returning a healthy response.

## Layer 5 - Session

Session functions establish, manage, and end an application's conversation. Check whether a session starts, remains usable, disconnects unexpectedly, or times out. Authentication or session-maintenance problems may also matter.

```bash
ss -tan
ss -tan | grep ESTAB
```

Socket states such as ESTAB, LISTEN, and TIME-WAIT provide transport evidence that can support a session investigation. They do not fully describe an application's session. In TCP/IP systems, session functions are often implemented in the application stack.

## Layer 6 - Presentation

Presentation functions concern representation, formatting, encoding, and encryption/decryption. Inspect TLS negotiation, the certificate, hostname, validity dates, and the expected data format.

```bash
openssl s_client -connect example.com:443 -servername example.com
openssl s_client -connect google.com:443 -servername google.com
```

These commands expose handshake and certificate information. Inspect verification errors explicitly; the mere presence of a certificate is not successful authentication. TLS spans functions that do not map perfectly onto a single OSI layer.

## Layer 7 - Application

This layer concerns protocols used by applications, including HTTP, HTTPS, DNS, SSH, FTP, SMTP, and IMAP. Check service availability, HTTP responses, name resolution, web-server configuration, service status, and application logs.

```bash
curl -I https://example.com
dig example.com
systemctl status nginx
ssh user@server_ip
```

Each command tests a different application or service stage.

## A Step-by-Step Website Investigation

1. Physical: Is the link available?
2. Data Link: Are local neighbor and MAC mappings appropriate?
3. Network: Are the address, gateway, and selected route correct?
4. Transport: Is the service listening and reachable?
5. Session: Does the conversation remain established and usable?
6. Presentation: Are TLS verification and data encoding correct?
7. Application: Does the service return the expected result?

```bash
ip link
ip addr
ip route
ping 8.8.8.8
ss -tuln
openssl s_client -connect example.com:443 -servername example.com
curl -I https://example.com
```

Start with link state, then addressing/routing, sockets, TLS, and the application response. A failed ping alone does not establish that HTTPS is unavailable.

## Summary

| Layer | Main checks | Example tools |
| --- | --- | --- |
| Physical | Cable, carrier, adapter | ip link, ethtool |
| Data Link | MAC, ARP, local segment | ip link, ip neigh |
| Network | IP, gateway, routes, reachability | ip addr, ip route, ping, traceroute |
| Transport | TCP/UDP, ports, sockets | ss, nc |
| Session | Conversation and interruptions | ss plus application logs |
| Presentation | TLS, certificate, encoding | openssl |
| Application | HTTP, DNS, SSH, service behavior | curl, dig, ssh, systemctl |

The OSI model explains communication responsibilities and offers a practical troubleshooting checklist. Testing each stage makes it easier to distinguish a link failure from an addressing, transport, TLS, or application problem. The English edition adds the noted protocol-boundary and diagnostic limitations to the original explanation.
