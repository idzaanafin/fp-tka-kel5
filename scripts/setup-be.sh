#!/bin/bash
# =============================================================================
# Setup script — Backend App Server (VM-1 dan VM-2)
# Jalankan sebagai user ubuntu setelah SSH ke VM:
#   chmod +x setup-be.sh && bash setup-be.sh
#
# Sebelum menjalankan, edit bagian CONFIG di bawah
# =============================================================================
set -e  # Hentikan jika ada perintah yang gagal

# =============================================================================
# CONFIG — edit sebelum dijalankan
# =============================================================================
MONGO_URI="mongodb://IP_VM3:27017/"              # IP internal VM-3 (dari tim DB)
JWT_SECRET="$(python3 -c 'import secrets; print(secrets.token_hex(32))')"  # Auto-generate
REPO_URL="https://github.com/USERNAME/fp-tka-kel5.git"  # Ganti dengan repo kelompok

# Untuk VM-1 (e2-medium, 2vCPU): GUNICORN_WORKERS=5
# Untuk VM-2 (e2-small, 2vCPU shared): GUNICORN_WORKERS=3
GUNICORN_WORKERS=5

echo "=== [1/6] Update sistem ==="
sudo apt-get update -q && sudo apt-get upgrade -y -q

echo "=== [2/6] Install dependencies OS ==="
sudo apt-get install -y -q \
    python3 python3-pip python3-venv \
    git curl nginx

echo "=== [3/6] Clone repo ==="
if [ -d "$HOME/app" ]; then
    echo "Repo sudah ada, pull update..."
    git -C "$HOME/app" pull
else
    git clone "$REPO_URL" "$HOME/app"
fi

echo "=== [4/6] Setup Python virtual environment & install packages ==="
python3 -m venv "$HOME/venv"
"$HOME/venv/bin/pip" install --upgrade pip -q
"$HOME/venv/bin/pip" install -r "$HOME/app/app/be/requirements.txt" -q

echo "=== [5/6] Konfigurasi environment variables ==="
sudo tee /etc/flask-app.env > /dev/null <<EOF
MONGO_URI=${MONGO_URI}
JWT_SECRET=${JWT_SECRET}
JWT_EXPIRES=86400
EOF
sudo chmod 600 /etc/flask-app.env  # Hanya root yang bisa baca
echo "JWT_SECRET yang di-generate: ${JWT_SECRET}"
echo "PENTING: Salin JWT_SECRET ini dan gunakan nilai yang SAMA di VM lain!"

echo "=== [6/6] Setup log directory ==="
sudo mkdir -p /var/log/flask-app
sudo chown ubuntu:ubuntu /var/log/flask-app

echo "=== Membuat gunicorn.conf.py dinamis ==="
cat > "$HOME/app/app/be/gunicorn.conf.py" <<EOF
import multiprocessing
bind = "0.0.0.0:5000"
workers = ${GUNICORN_WORKERS}
worker_class = "gthread"
threads = 2
max_requests = 1000
max_requests_jitter = 100
timeout = 30
keepalive = 5
accesslog = "/var/log/flask-app/access.log"
errorlog = "/var/log/flask-app/error.log"
loglevel = "warning"
preload_app = True
EOF

echo "=== Setup systemd service ==="
sudo cp "$HOME/app/app/be/app.service" /etc/systemd/system/flask-app.service
sudo systemctl daemon-reload
sudo systemctl enable flask-app
sudo systemctl start flask-app

echo "=== Test health check ==="
sleep 3
if curl -sf http://localhost:5000/health > /dev/null; then
    echo "✓ Flask berjalan di port 5000"
else
    echo "✗ Flask GAGAL start — cek log: sudo journalctl -u flask-app -n 50"
    exit 1
fi

echo ""
echo "============================================"
echo "Setup BERHASIL!"
echo "Flask berjalan di: http://localhost:5000"
echo "Status service: sudo systemctl status flask-app"
echo "Log: sudo journalctl -u flask-app -f"
echo "============================================"
