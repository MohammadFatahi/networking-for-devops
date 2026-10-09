#!/bin/bash
cd "$(dirname "$0")" || exit 1
if [ "$(id -u)" -ne 0 ]; then
    echo 'Run with sudo: sudo bash network_monitor.sh'
    exit 1
fi
if ! command -v tshark > /dev/null; then
    echo 'tshark is required for measuring traffic per IP.'
    exit 1
fi
interface=$(ip route show default | awk 'NR==1{print $5}')
if [ -z "$interface" ]; then
    echo 'No default network interface found.'
    exit 1
fi
tshark -i "$interface" -l -f ip -T fields \
    -e ip.src -e ip.dst -e ip.len > traffic.tsv 2> capture_status.txt &
capture=$!
trap 'kill "$capture" 2>/dev/null' EXIT
trap 'exit 0' INT TERM
sleep 1
while true; do
    if ! kill -0 "$capture" 2>/dev/null; then
        cat capture_status.txt
        exit 1
    fi
    lines_before=$(wc -l < traffic.tsv)
    rx1=$(awk -v dev="$interface:" '$1==dev{print $2}' /proc/net/dev)
    tx1=$(awk -v dev="$interface:" '$1==dev{print $10}' /proc/net/dev)
    start=$(date +%s)
    sleep 5
    lines_after=$(wc -l < traffic.tsv)
    seconds=$(( $(date +%s) - start ))
    rx2=$(awk -v dev="$interface:" '$1==dev{print $2}' /proc/net/dev)
    tx2=$(awk -v dev="$interface:" '$1==dev{print $10}' /proc/net/dev)
    {
        date -Is
        ip -s link show "$interface"
        echo "Sample interval: $seconds seconds"
        echo "Download: $(( (rx2-rx1)/seconds )) bytes/s"
        echo "Upload: $(( (tx2-tx1)/seconds )) bytes/s"
        echo "Active TCP connections: $(ss -Htn state established | wc -l)"
        echo 'Top 5 IPv4 addresses by sent + received packet bytes:'
        tail -n "+$((lines_before+1))" traffic.tsv | head -n "$((lines_after-lines_before))" |
            awk 'NF==3 {bytes[$1]+=$3; if($2!=$1) bytes[$2]+=$3}
                 END {for(ip in bytes) print bytes[ip], ip}' | sort -nr | head -5
        echo
    } | tee -a monitoring_log.txt
done
