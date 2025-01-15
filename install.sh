#!/bin/bash

# Install Netbird
echo "Installing Netbird..."
curl -fsSL https://pkgs.netbird.io/install.sh | sh

# Membuat file run.sh di dalam instalasi
echo "Creating run.sh..."
cat << 'EOF' > /root/run.sh
#!/bin/bash

# Cek apakah layanan Netbird berjalan
STATUS=$(/etc/init.d/netbird status)

# Jika Netbird tidak berjalan, coba install ulang dan start layanan
if echo "$STATUS" | grep -q "Stopped"; then
    echo "Netbird is stopped. Installing and starting Netbird..."
    netbird service install 2>/dev/null
    /etc/init.d/netbird start
else
    echo "Netbird is running."
fi

# Pastikan Netbird terkoneksi
netbird up
EOF

# Memberikan izin eksekusi pada run.sh
chmod +x /root/run.sh

# Menambahkan run.sh ke /etc/rc.local untuk dijalankan otomatis saat boot
if ! grep -q "/root/run.sh" /etc/rc.local; then
    echo "/root/run.sh" >> /etc/rc.local
    echo "exit 0" >> /etc/rc.local
fi

echo "Setup completed. Netbird will auto-start and be monitored after reboot."

# Pastikan exit hanya satu kali
exit 0
