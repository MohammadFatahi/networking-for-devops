#!/bin/bash
cd "$(dirname "$0")" || exit 1
{
    date -Is
    echo 'GET /posts/1'
    curl -i --connect-timeout 5 --max-time 25 -X GET https://jsonplaceholder.typicode.com/posts/1
    echo "curl exit code: $?"
    echo 'POST /posts'
    curl -i --connect-timeout 5 --max-time 25 -X POST https://jsonplaceholder.typicode.com/posts \
        -H 'Content-Type: application/json' -d '{"title":"test","body":"content","userId":1}'
    echo "curl exit code: $?"
    echo 'PUT /posts/1'
    curl -i --connect-timeout 5 --max-time 25 -X PUT https://jsonplaceholder.typicode.com/posts/1 \
        -H 'Content-Type: application/json' -d '{"id":1,"title":"updated","body":"content","userId":1}'
    echo "curl exit code: $?"
    echo 'DELETE /posts/1'
    curl -i --connect-timeout 5 --max-time 25 -X DELETE https://jsonplaceholder.typicode.com/posts/1
    echo "curl exit code: $?"
    echo 'GET /posts/99999999 - inspect the 404 response'
    curl -i --connect-timeout 5 --max-time 25 https://jsonplaceholder.typicode.com/posts/99999999
    echo "curl exit code: $?"
    echo 'HTTP: 200 OK, 201 Created, 404 Not Found, 500 Internal Server Error.'
    echo 'The response status line contains the HTTP code; -i also displays headers.'
    echo 'The curl exit code differs from the HTTP code; a 404 response can accompany curl exit code zero.'
    echo 'This demonstration API does not persist POST/PUT/DELETE changes.'
} > http_methods_report.txt 2>&1
cat http_methods_report.txt
