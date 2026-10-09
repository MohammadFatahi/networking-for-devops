# English Answers and Recorded Results

The directories below contain translations of the supplied explanations, scripts, configuration files, and historical output. They are organized to match the unified 12-lab workbook. Follow the file links in each directory README to inspect a complete answer or report.

## Lab Index

1. [Preparing a Web Server](lab-01/README.md): addressing, Netplan, ping, DNS, and local socket inspection.
2. [Troubleshooting Network Problems](lab-02/README.md): capture observations, Wireshark analysis, port checks, and the OSI guide.
3. [Network Security](lab-03/README.md): firewall setup, recorded rules, and suspicious-traffic reports.
4. [DNS, Routing, and Topology](lab-04/README.md): resolver settings, route/path observations, and the star-network explanation.
5. [Protocols and Performance](lab-05/README.md): TCP/UDP comparison and the supplied iperf3/ping results.
6. [SSL/TLS and HTTPS](lab-06/README.md): certificate generation, TLS inspection, a local server, and best practices.
7. [FTP and File Transfer](lab-07/README.md): local FTP setup, anonymous downloads, authenticated uploads, and transfer-method comparison.
8. [HTTP and Web Services](lab-08/README.md): a static server, method tests, and header interpretation.
9. [DNS, CDNs, and BIND](lab-09/README.md): record examples, query tables, CDN headers, and a theoretical BIND zone.
10. [SSH and Remote Management](lab-10/README.md): key authentication, client profiles, forwarding, and a hardening sample.
11. [Monitoring and Logging](lab-11/README.md): interval-based traffic rates, top addresses by bytes, log patterns, and a dashboard.
12. [Practical Troubleshooting](lab-12/README.md): diagnosis guides, slow-network observations, and a local stalled-SSH simulation.

## How to Read the Evidence

The [sanitized original command history](../results/commands_history.txt) records the supplied second-set execution sequence. Its scenario paths use the original folder names; use the lab mapping above when working in this consolidated edition.

- **Recorded reports** retain the supplied measurements and results. Identifying host values are redacted; this is not a fresh execution record.
- **Theoretical answers** explain proposed configuration or diagnosis without claiming that every service was deployed.
- **Sample logs** are educational fixtures. Their test output is separate from actual server logs.
- **Unavailable or empty outputs** are disclosed. In particular, the first set's port report was empty; its contents have not been reconstructed as if measured.
- **Raw local originals** are stored under `.local-originals/` on the author's machine, excluded from Git and public bundles. This includes original language documents, packet captures, screenshots, editor backups, and the TLS private key.

## Example Interpretations from the Supplied Reports

The Lab 5 TCP test reports 4.30 Mbit/s at the sender and 3.21 Mbit/s at the receiver over different reported intervals. Its four ping replies give an average RTT of 190.430 ms and no loss among those four probes. The UDP receiver reports 89.262 ms jitter. These observations describe that test; the unusually different UDP sending/receiving totals and durations deserve investigation before concluding that the path has no loss.

The routing report contains two sets of hop observations whose timings differ. Do not treat the summarized hop averages as calculations from the three traceroute samples printed above them. Intermediate nonresponses do not alone establish forwarding failure.

HTTPS verification results, public DNS records, and response headers are time-dependent. A future rerun can return another certificate, address, header, or status code. Inspect the current output and record its timestamp.

## Reproducing the Examples

Work in the relevant lab directory. Inspect a script before executing it, choose the correct interface or server address, and install only the needed tools. Generate fresh TLS and SSH keys locally. The chapter and workbook explain where loopback tests are valid and where another client is needed.

In a dedicated lab host, these common tools support the collection: Bash, Python 3, iproute2, curl, OpenSSL, dnsutils, netcat, tcpdump/tshark, iperf3, and OpenSSH. UFW, vsftpd, and BIND checks are relevant to their specific labs. Do not run every setup script blindly on your workstation.
