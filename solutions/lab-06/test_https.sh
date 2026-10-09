#!/bin/bash
cd "$(dirname "$0")" || exit 1
{
    date -Is
    echo '1. curl -vI https://google.com'
    curl -vI --connect-timeout 5 --max-time 20 https://google.com 2>&1 |
        grep -E 'SSL|TLS|expire|HTTP/|curl:'
    echo '2. Check the chain and hostname with openssl s_client'
    timeout 20 openssl s_client -connect google.com:443 -servername google.com \
        -showcerts -verify_hostname google.com -verify_return_error < /dev/null
    echo '3. Certificate validity dates'
    echo | timeout 20 openssl s_client -connect google.com:443 \
        -servername google.com 2>/dev/null | openssl x509 -noout -dates
    echo '4. Expired certificate: a normal request should report a certificate error'
    curl -I --connect-timeout 5 --max-time 20 https://expired.badssl.com
    echo "curl exit code: $?"
    echo 'The same request with --insecure, only to demonstrate the difference in this test'
    curl --insecure -vI --connect-timeout 5 --max-time 20 https://expired.badssl.com
    echo "curl exit code: $?"
    echo 'The TLS version appears in curl output; Verify return code appears in OpenSSL output.'
    echo 'Verify return code: 0 indicates successful verification; -k disables verification.'
    echo 'If badssl times out, the certificate comparison is inconclusive; timeout is not a certificate error.'
} > https_test_report.txt 2>&1
cat https_test_report.txt
