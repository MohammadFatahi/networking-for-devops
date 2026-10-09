#!/usr/bin/env bash
{
echo 'Throughput:'
echo
iperf3 -c 198.51.100.10
echo
echo 'Packet loss and Latency:'
echo
ping -c 4 198.51.100.10
echo
echo 'Jitter:'
echo
iperf3 -c 198.51.100.10 -u -b 100M
} > performance_report.txt
