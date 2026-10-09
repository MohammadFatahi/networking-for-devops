#!/bin/bash
cd "$(dirname "$0")" || exit 1
{
    date -Is
    for site in https://github.com https://google.com https://stackoverflow.com; do
        echo "curl -I $site"
        curl -I --connect-timeout 5 --max-time 20 "$site"
        echo "curl exit code: $?"
    done
    echo 'Content-Type: the media type, such as HTML or JSON.'
    echo 'Server: server software identification; the header may be absent.'
    echo 'Cache-Control: caching directives governing storage and reuse.'
    echo 'X-Frame-Options: restricts embedding the page in a frame.'
    echo 'Content-Security-Policy: restricts permitted sources such as scripts and images.'
    echo 'Content-Security-Policy-Report-Only reports violations without enforcing the policy.'
    echo 'Each curl observation applies to that response; 301 indicates a redirect.'
} > http_headers_analysis.txt 2>&1
cat http_headers_analysis.txt
