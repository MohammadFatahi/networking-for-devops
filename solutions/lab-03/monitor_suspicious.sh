#!/bin/bash

{
echo "IPs with more than 100 connections:"
echo
ss -tn state established | awk 'NR>1 {print $4}' | cut -d: -f1 | sort | uniq -c | sort -nr | awk '$1 >100'
echo
echo "Failed Efforts to Connect the Server by Incorrect Password:"

echo
cat /var/log/auth.log | grep 'ssh' | grep 'Failed password'
echo

echo "IPs that are connected to unusual ports:"
echo
ss -tn state established | awk -F: 'NR>1 {print $2}' | awk '$1>10000' | awk '{print $2} '

} > security_report1.txt
