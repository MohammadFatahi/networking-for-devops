#!/bin/bash
cd "$(dirname "$0")" || exit 1
{
    date -Is
    for type in A AAAA MX TXT NS SOA; do
        echo "dig google.com $type"
        dig +time=3 +tries=1 google.com "$type"
    done
    echo 'dig www.wikipedia.org CNAME'
    dig +time=3 +tries=1 www.wikipedia.org CNAME
    echo 'Examples from other domains when Google record queries receive no answer:'
    for type in MX NS SOA; do
        echo "dig cloudflare.com $type"
        dig +time=3 +tries=1 cloudflare.com "$type"
    done
    echo 'dig example.com TXT'
    dig +time=3 +tries=1 example.com TXT
} > dns_record_examples.txt 2>&1
{
    date -Is
    echo 'curl -I https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js'
    curl -I --connect-timeout 5 --max-time 20 https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js
    echo "curl exit code: $?"
} > cdn_headers_test.txt 2>&1
