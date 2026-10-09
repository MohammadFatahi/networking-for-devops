#!/bin/bash

{ echo "Connectivity Test:"
echo
echo "Ping Test: 8.8.8.8"
echo

ping -c 4  8.8.8.8
echo
echo "Ping Test: google.com"
echo

ping -c 4 google.com

echo
echo "DNS Resolution:"
echo
nslookup github.com


} > connectres.txt
