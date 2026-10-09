#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p certs
openssl req -x509 -newkey rsa:2048 -nodes \
    -keyout certs/myapp.key -out certs/myapp.crt -days 365 \
    -subj "/C=IR/ST=Tehran/L=Tehran/O=MyCompany/CN=myapp.local"
chmod 600 certs/myapp.key
{
    date -Is
    echo 'openssl x509 -in certs/myapp.crt -text -noout'
    openssl x509 -in certs/myapp.crt -text -noout
    echo 'openssl rsa -in certs/myapp.key -check -noout'
    openssl rsa -in certs/myapp.key -check -noout
    echo 'The certificate is for myapp.local and is valid for 365 days.'
    echo 'Subject and Issuer are identical because the certificate is self-signed.'
    echo 'The -noout option prevents the private key from being printed during inspection.'
} > ssl_generation.txt 2>&1
cat ssl_generation.txt
