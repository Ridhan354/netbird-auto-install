#!/bin/sh

# Check if Netbird service is running
STATUS=$(/etc/init.d/netbird status)

# If Netbird is stopped, reinstall and start the service
if echo "$STATUS" | grep -q "Stopped"; then
    echo "Netbird is stopped. Installing and starting Netbird..."
    netbird service install 2>/dev/null
    /etc/init.d/netbird start
else
    echo "Netbird is running."
fi

# Ensure Netbird is connected
netbird up
