#!/bin/bash
cd "$(dirname "$0")" || exit 1
python3 silent_server.py > silent_server_output.txt 2>&1 &
pid=$!
trap 'kill "$pid" 2>/dev/null' EXIT
sleep 1
if ! kill -0 "$pid" 2>/dev/null; then
    cat silent_server_output.txt
    exit 1
fi
{
    date -Is
    echo 'Local simulation: open TCP port with no SSH banner.'
    echo 'timeout 5 ssh -o ConnectTimeout=3 -o BatchMode=yes -p 2299 test@localhost'
    timeout 5 ssh -o ConnectTimeout=3 -o BatchMode=yes -p 2299 test@localhost
    result=$?
    echo "Exit code: $result"
    echo '124 means the outer timeout expired; 255 is an SSH error.'
    if [ "$result" -eq 124 ] || [ "$result" -eq 255 ]; then
        echo 'Compare the SSH error above: it should report a banner timeout.'
    else
        echo 'Unexpected result.'
        exit 1
    fi
} > timeout_simulation_report.txt 2>&1
cat timeout_simulation_report.txt
