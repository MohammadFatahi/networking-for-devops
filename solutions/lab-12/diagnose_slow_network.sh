#!/bin/bash
cd "$(dirname "$0")" || exit 1
{
    date -Is
    echo '1. Latency and packet loss'
    for server in 8.8.8.8 1.1.1.1 example.com; do
        echo "ping -c 10 -W 2 $server"
        ping -c 10 -W 2 "$server" > ping_result.txt 2>&1
        cat ping_result.txt
        if grep -q '100% packet loss' ping_result.txt; then
            echo 'No ICMP reply: check reachability and ICMP filtering.'
        fi
        average=$(awk -F/ '/^(rtt|round-trip)/{print $5}' ping_result.txt)
        if [ -n "$average" ]; then
            awk -v avg="$average" 'BEGIN{if(avg>100) print "Average RTT >100 ms: compare route, distance and network load."}'
        fi
    done
    echo '2. DNS response time'
    for domain in google.com github.com stackoverflow.com; do
        echo "dig $domain"
        dig +time=3 +tries=1 "$domain" > dns_result.txt 2>&1
        grep -E 'status:|Query time:|SERVER:' dns_result.txt
        awk '/Query time:/{if($4>100) print "DNS query >100 ms: compare resolver and cached results."}' dns_result.txt
    done
    echo '3. Interface MTU'
    ip link show | grep mtu
    echo '4. Test a 1500-byte IPv4 packet: 1472 bytes payload + 28 bytes headers'
    ping -M do -s 1472 -c 3 -W 2 8.8.8.8
    echo 'Packet loss may come from congestion or filtering; no reply does not prove an MTU issue.'
    echo 'High RTT may also come from distance. Compare another route or a wired connection.'
} > network_performance_diagnosis.txt 2>&1
cat network_performance_diagnosis.txt
