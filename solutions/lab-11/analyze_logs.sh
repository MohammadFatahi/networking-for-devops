#!/bin/bash
cd "$(dirname "$0")" || exit 1
source_path=${1:-/var/log}
pattern='sshd|systemd-networkd|NetworkManager|dhcp|systemd-resolved|nginx|vsftpd|UFW|firewall|TCP|UDP'
if [ -f "$source_path" ]; then
    files="$source_path"
else
    files=$(find "$source_path" -type f \( -name '*.log' -o -name syslog -o -name kern.log -o -name auth.log \) 2>/dev/null)
fi
: > network_events.txt
{
    date -Is
    echo 'Network-related readable text log files:'
    for file in $files; do
        if [ ! -r "$file" ]; then
            echo "Cannot read: $file"
        elif grep -qiE "$pattern" "$file"; then
            echo "$file"
            grep -hiE "$pattern" "$file" >> network_events.txt
        elif [[ "$file" == *nginx* || "$file" == *vsftpd* ]]; then
            echo "$file"
            cat "$file" >> network_events.txt
        fi
    done
    echo 'Latest 10 matching events with ISO timestamps:'
    grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}T' network_events.txt | sort | tail -10
    echo 'Other timestamp formats are included in counts but are not ordered in this list.'
    echo 'IPv4 occurrence counts:'
    grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' network_events.txt | sort | uniq -c | sort -nr
    echo 'IPs with at least 3 failed login events:'
    grep -iE 'Failed password|Failed publickey|Invalid user|authentication failure' network_events.txt |
        grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | awk '$1>=3' | sort -nr
    echo 'Repeated failures need investigation; they are not proof of an attack.'
} > log_analysis_report.txt 2>&1
cat log_analysis_report.txt
