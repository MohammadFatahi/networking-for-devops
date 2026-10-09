#!/bin/bash
cd "$(dirname "$0")" || exit 1
{
    date -Is
    echo 'Domain | IPv4 | TTL (seconds) | DNS server | Query time (ms)'
    for domain in google.com github.com stackoverflow.com linkedin.com; do
        response=$(dig +time=3 +tries=1 "$domain" A)
        server=$(echo "$response" | awk '/^;; SERVER:/{print $3}')
        query_time=$(echo "$response" | awk '/Query time:/{print $4}')
        if echo "$response" | awk '$4=="A"{print $5}' | grep -q .; then
            echo "$response" | awk -v domain="$domain" -v server="$server" -v ms="$query_time" \
                '$4=="A"{print domain " | " $5 " | " $2 " | " server " | " ms}'
        else
            echo "$domain | no A answer | - | $server | $query_time"
            echo "$response"
        fi
    done
    echo 'IP addresses and TTLs were extracted from ANSWER SECTION; the resolver was extracted from SERVER.'
    echo 'Query time measures the DNS exchange, not the time to open a website.'
    echo '127.0.0.53 in SERVER means the query was answered through the local stub resolver.'
} > dns_analysis_report.txt 2>&1
cat dns_analysis_report.txt
