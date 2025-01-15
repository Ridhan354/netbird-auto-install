#!/bin/bash

# Install Netbird
echo "Installing Netbird..."
curl -fsSL https://pkgs.netbird.io/install.sh | sh

# Copy run.sh to /root and set permissions
echo "Setting up run.sh..."
cp run.sh /root/run.sh
chmod +x /root/run.sh

# Add run.sh to /etc/rc.local for auto-start on boot
if ! grep -q "/root/run.sh" /etc/rc.local; then
    echo "/root/run.sh" >> /etc/rc.local
    echo "exit 0" >> /etc/rc.local
fi

echo "Setup completed. Netbird will auto-start and be monitored after reboot."
