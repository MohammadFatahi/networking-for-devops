# TCP versus UDP

## 1. Main Differences

1. **Connection:** TCP normally establishes a connection through SYN, SYN-ACK, and ACK, and ends it with FIN or RST. UDP sends datagrams without this transport handshake.
2. **Reliability:** TCP retransmits missing data and delivers an ordered byte stream. UDP does not itself retransmit or reorder data; an application can implement additional recovery.
3. **Flow and congestion control:** TCP regulates transmission using receiver flow control and congestion control. UDP itself does not provide equivalent mechanisms; the application protocol must choose appropriate behavior.
4. **Headers and overhead:** The basic TCP header is 20 bytes plus options; the UDP header is 8 bytes. Less overhead does not make every UDP application faster.
5. **Application interface:** TCP is a byte stream without preserved message boundaries. UDP preserves datagram boundaries.
6. **Failure:** A disappeared TCP peer may eventually cause timeout or reset. With UDP, the application may see missing replies and needs its own detection or timeout logic.

## 2. Suitable Transports

| Service | Typical transport | Reason |
| --- | --- | --- |
| Video streaming | Depends on delivery protocol | Real-time media often uses UDP-based transport because late frames lose value. HTTP streaming may use TCP or HTTP/3 over QUIC/UDP. |
| FTP | TCP | Both control and data connections need reliable delivery. |
| DNS | UDP and TCP | Many ordinary queries use UDP; TCP supports cases including truncated responses and zone transfers. |
| HTTP/HTTPS | TCP for HTTP/1.1 and HTTP/2; QUIC/UDP for HTTP/3 | The application needs reliable streams. QUIC supplies reliability above UDP. |
| VoIP | Often RTP over UDP | Waiting to retransmit old speech can increase delay. |
| Database queries | Commonly TCP | Database protocols such as MySQL and PostgreSQL use ordered, reliable communication. |

These transport qualifications clarify simplified claims in the original answer.

## 3. What the Recorded Host Was Using

Command: `netstat -tuln`.

The supplied answer records TCP listeners for SSH on 22, nginx HTTP on 80, systemd-resolved on loopback port 53, CUPS on 631, a local application on 4000, and a Tailscale endpoint. It also records UDP endpoints for DNS, multicast DNS, Tailscale/WireGuard, and chrony time synchronization.

The host therefore used both transports at the time: TCP for SSH and the web server, and UDP for DNS, multicast discovery, time synchronization, and the VPN tunnel. The answer says port 443 was not listening.

```text
udp  0 0 127.0.0.54:53    0.0.0.0:*
udp  0 0 127.0.0.53:53    0.0.0.0:*
udp  0 0 127.0.0.1:323    0.0.0.0:*
udp  0 0 0.0.0.0:41641    0.0.0.0:*
udp  0 0 0.0.0.0:5353     0.0.0.0:*
udp  0 0 224.0.0.251:5353 0.0.0.0:*
udp6 0 0 :::41641        :::*
udp6 0 0 :::5353         :::*
udp6 0 0 ::1:323         :::*
tcp  0 0 0.0.0.0:22     0.0.0.0:* LISTEN
tcp  0 0 0.0.0.0:80     0.0.0.0:* LISTEN
tcp  0 0 127.0.0.53:53  0.0.0.0:* LISTEN
tcp6 0 0 :::22          :::* LISTEN
tcp6 0 0 :::80          :::* LISTEN
```

These are historical supplied observations, not a fresh measurement. The source referred to `ports_status.txt` for the full TCP output, but that supplied file is empty. This edition retains that limitation rather than inventing the missing report.
