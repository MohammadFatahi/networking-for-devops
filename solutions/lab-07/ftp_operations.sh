#!/bin/bash
set -e
cd "$(dirname "$0")"
read -s -p 'FTP password for network2student: ' password
echo
{
    date -Is
    echo '1. List public files'
    curl --connect-timeout 5 --max-time 15 ftp://127.0.0.1/
    echo '2. Download sample.txt'
    curl --connect-timeout 5 --max-time 15 ftp://127.0.0.1/sample.txt -o sample.txt
    cat sample.txt
    echo '3. Upload using the dedicated account'
    echo 'Upload test file' > upload.txt
    curl --connect-timeout 5 --max-time 15 -u "network2student:$password" \
        -T upload.txt ftp://127.0.0.1/upload/upload.txt
    echo '4. Download the uploaded file'
    curl --connect-timeout 5 --max-time 15 -u "network2student:$password" \
        ftp://127.0.0.1/upload/upload.txt -o downloaded_upload.txt
    cmp upload.txt downloaded_upload.txt
    echo 'Upload and download match.'
} > ftp_operations_test.txt 2>&1
cat ftp_operations_test.txt
