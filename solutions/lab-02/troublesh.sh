#!/bin/bash

sudo tcpdump -i any port 80 -w http_capture.pcap -c 100

sudo tcpdump -i any port 53 -w dns_capture.pcap -c 100
