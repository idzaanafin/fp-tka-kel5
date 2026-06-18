import multiprocessing

# Binding
bind = "0.0.0.0:5000"

# Workers: (2 × CPU) + 1 adalah rumus standar untuk I/O-bound workload (Flask + MongoDB)
# Sesuaikan sesuai VM yang digunakan:
#   VM-1 e2-medium (2vCPU) → 5 workers
#   VM-2 e2-small  (2vCPU shared) → 3 workers (lebih konservatif)
workers = (2 * multiprocessing.cpu_count()) + 1

# gthread lebih efisien untuk request yang menunggu I/O (query MongoDB)
worker_class = "gthread"
threads = 2

# Batas koneksi per worker sebelum di-recycle — cegah memory leak
max_requests = 1000
max_requests_jitter = 100

# Timeout dan keepalive
timeout = 30
keepalive = 5

# Logging
accesslog = "/var/log/flask-app/access.log"
errorlog = "/var/log/flask-app/error.log"
loglevel = "warning"

# Performa: nonaktifkan reloading di production
reload = False
preload_app = True
