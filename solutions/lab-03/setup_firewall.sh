#!/bin/bash

# Local network allowed to access SSH
LOCAL_NETWORK="192.168.1.0/24"

echo "Configuring firewall..."

# Reset existing UFW rules
sudo ufw --force reset

# Default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH only from local network
sudo ufw allow from "$LOCAL_NETWORK" to any port 22 proto tcp

# Allow HTTP from everywhere
sudo ufw allow 80/tcp

# Allow HTTPS from everywhere
sudo ufw allow 443/tcp

# Enable firewall
sudo ufw --force enable

# Save active firewall rules
sudo ufw status numbered > firewall_rules.txt

echo "Firewall configuration completed."
echo "Rules saved to firewall_rules.txt."
