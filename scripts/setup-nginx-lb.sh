#!/bin/bash
# =============================================================================
# Setup Nginx Load Balancer — HANYA dijalankan di Droplet-1
# Jalankan SETELAH setup-be.sh dan SETELAH Droplet-2 sudah berjalan
#
# Syarat: Droplet-2 sudah setup dan Flask berjalan di port 5000
# Cara dapat private IP Droplet-2: DO Console → Droplet → Networking → Private IP
# =============================================================================
set -e

# =============================================================================
# CONFIG — edit sebelum dijalankan
# =============================================================================
VM2_INTERNAL_IP="IP_INTERNAL_DROPLET2"  # Ganti dengan private IP Droplet-2 dari DO Console

echo "=== Validasi IP Droplet-2 ==="
if [ "$VM2_INTERNAL_IP" = "IP_INTERNAL_DROPLET2" ]; then
    echo "ERROR: Edit VM2_INTERNAL_IP di script ini terlebih dahulu!"
    exit 1
fi

echo "=== Cek konektivitas ke Droplet-2 ==="
if curl -sf "http://${VM2_INTERNAL_IP}:5000/health" > /dev/null; then
    echo "✓ Droplet-2 bisa dihubungi"
else
    echo "✗ Droplet-2 tidak bisa dihubungi di port 5000"
    echo "Pastikan:"
    echo "  1. Droplet-2 sudah menjalankan setup-be.sh"
    echo "  2. Firewall DO (fw-app) sudah attach ke Droplet-2 dan port 5000 diizinkan dari VPC"
    exit 1
fi

echo "=== Install Nginx ==="
sudo apt-get install -y -q nginx

echo "=== Konfigurasi Nginx Load Balancer ==="
sudo tee /etc/nginx/sites-available/app > /dev/null <<EOF
upstream flask_backend {
    server 127.0.0.1:5000;
    server ${VM2_INTERNAL_IP}:5000;
}

server {
    listen 80;
    server_name _;

    client_max_body_size 10M;

    gzip on;
    gzip_types application/json text/plain;
    gzip_min_length 1024;

    location / {
        proxy_pass http://flask_backend;
        proxy_set_header Host              \$host;
        proxy_set_header X-Real-IP         \$remote_addr;
        proxy_set_header X-Forwarded-For   \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_connect_timeout 10s;
        proxy_send_timeout    30s;
        proxy_read_timeout    30s;
        proxy_buffering off;
    }

    location /health {
        proxy_pass http://flask_backend;
        access_log off;
    }
}
EOF

echo "=== Aktifkan config dan test ==="
sudo ln -sf /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app
sudo rm -f /etc/nginx/sites-enabled/default  # Hapus default config

sudo nginx -t  # Test config syntax
sudo systemctl reload nginx

echo "=== Verifikasi load balancer ==="
sleep 2
for i in 1 2 3; do
    RESP=$(curl -sf http://localhost/health || echo "GAGAL")
    echo "Request ${i}: ${RESP}"
done

echo ""
echo "============================================"
echo "Nginx Load Balancer AKTIF!"
echo "Akses API: http://$(curl -sf ifconfig.me)"
echo "Config Nginx: /etc/nginx/sites-available/app"
echo "Log access: /var/log/nginx/access.log"
echo "Log error: /var/log/nginx/error.log"
echo "============================================"
