#!/bin/bash

{ echo "Network Interfaces and IP Adressess:"
echo
ip addr
echo
echo "Default Gateway:"
echo
ip route
echo
echo "Upstream DNS Server:"
echo
resolvectl status
echo
echo "Local DNS Server:"
echo
cat /etc/resolv.conf

} > network_info.txt
