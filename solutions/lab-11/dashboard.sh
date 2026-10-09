#!/bin/bash
cd "$(dirname "$0")" || exit 1
while true; do
    clear
    echo "=== Network Dashboard $(date -Is) ==="
    echo 'Interfaces and IP addresses:'
    ip -br addr
    echo "Active TCP connections: $(ss -Htn state established | wc -l)"
    echo 'Open TCP/UDP ports:'
    ss -lntu
    echo 'DNS servers:'
    resolvectl dns
    echo 'Latest 5 network service log entries:'
    journalctl -u ssh -u systemd-networkd -u NetworkManager -u systemd-resolved -n 5 --no-pager
    sleep 10
done
