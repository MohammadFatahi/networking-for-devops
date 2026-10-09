#!/bin/bash

TARGET=${1:-localhost}

echo "================================================="
echo "   Port Connection Test (Target: $TARGET)"
echo "================================================="

# Check a service port; keep braces and if/fi pairs complete.
check_port() {
    local PORT=$1
    local SERVICE=$2

    if nc -zv $TARGET $PORT > /dev/null 2>&1; then
        echo "[REACHABLE] $SERVICE (Port $PORT) is reachable."
    else
        echo "[UNREACHABLE] $SERVICE (Port $PORT) is not reachable."
    fi
}

# Run the service checks
check_port 80 "Web Server"
check_port 22 "SSH"
check_port 3306 "MySQL"

echo "================================================="
