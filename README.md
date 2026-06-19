# FINAL PROJECT TEKNOLOGI KOMPUTASI AWAN 2026

### Kelas: A
### Kelompok: 5

|Nama|NRP|
|----|---|
|Ahmad Idza Anafin|5027241017|
|Nadia Fauziazahra K.|5027241094|
|Muhammad Ziddan Habibi|5027241122|
|Mey Rosalina|5027241004|
|Erlinda Annisa|5027241108|
|Ahmad Wildan Fawwaz|5027241001|

---

## Daftar Isi

1. [Pendahuluan](#1-pendahuluan)
2. [Rancangan Arsitektur Cloud](#2-rancangan-arsitektur-cloud)
3. [Implementasi Teknis](#3-implementasi-teknis)
4. [Pengujian Aplikasi](#4-pengujian-aplikasi)
5. [Load Testing](#5-load-testing)
6. [Kesimpulan dan Saran](#6-kesimpulan-dan-saran)

---

## 1. Pendahuluan

### 1.1 Latar Belakang

Perusahaan rintisan (startup) di bidang e-commerce sedang mengembangkan platform jual-beli online dan membutuhkan backend **Order Processing Service** — layanan inti yang menangani pembuatan pesanan, pengecekan status, dan riwayat transaksi. Sebagai Cloud Engineer, tim diminta untuk mendeploy, mengonfigurasi, dan mengoptimalkan layanan tersebut di atas infrastruktur cloud agar mampu menangani lonjakan traffic (flash sale, promo, dsb.) secara andal dan efisien.

### 1.2 Permasalahan

Dengan **budget maksimal Rp1.300.000 per bulan (≈ 75 US$)**, tim merancang dan mengimplementasikan arsitektur cloud terbaik yang mampu menerima request tertinggi secara stabil, tanpa melebihi batas anggaran yang ditentukan.

### 1.3 Spesifikasi Aplikasi

Backend disediakan dalam bentuk REST API berbasis **Python (Flask)** dengan database **MongoDB**. Source code tersedia di folder `Resources/BE/app.py`.

#### 1.3.1 Backend — Endpoints

**a. Create Order**
- **Endpoint:** `POST /order`
- **Deskripsi:** Membuat pesanan baru. Sistem akan menyimpan data pesanan beserta timestamp dan status awal `"pending"`.
- **Request Body:**
  ```json
  {
    "product": "Nama Produk",
    "quantity": 2,
    "price": 150000
  }
  ```
- **Response (201 Created):**
  ```json
  {
    "order_id": "<uuid>",
    "product": "Nama Produk",
    "quantity": 2,
    "price": 150000,
    "total": 300000,
    "status": "pending",
    "created_at": "2025-06-15T10:00:00Z"
  }
  ```

**b. Get Order Status**
- **Endpoint:** `GET /order/<order_id>`
- **Deskripsi:** Mengambil status dan detail sebuah pesanan berdasarkan `order_id`.
- **Response (200 OK):**
  ```json
  {
    "order_id": "<uuid>",
    "product": "Nama Produk",
    "quantity": 2,
    "price": 150000,
    "total": 300000,
    "status": "pending",
    "created_at": "2025-06-15T10:00:00Z"
  }
  ```
- **Response (404 Not Found):**
  ```json
  { "error": "Order not found" }
  ```

**c. Get Order History**
- **Endpoint:** `GET /orders`
- **Deskripsi:** Mengambil seluruh riwayat pesanan, diurutkan dari yang paling baru.
- **Response (200 OK):**
  ```json
  [
    {
      "order_id": "<uuid>",
      "product": "Nama Produk",
      "quantity": 2,
      "price": 150000,
      "total": 300000,
      "status": "pending",
      "created_at": "2025-06-15T10:00:00Z"
    },
    { "...": "..." }
  ]
  ```

**d. Update Order Status**
- **Endpoint:** `PUT /order/<order_id>`
- **Deskripsi:** Mengubah status pesanan (misalnya dari `"pending"` menjadi `"processing"` atau `"completed"`).
- **Request Body:**
  ```json
  { "status": "completed" }
  ```
- **Response (200 OK):**
  ```json
  {
    "order_id": "<uuid>",
    "status": "completed"
  }
  ```

#### 1.3.2 Frontend

Selain backend, disediakan pula **Frontend** sederhana (`Resources/FE/index.html` dan `styles.css`) yang memungkinkan pengguna membuat pesanan, melihat status, dan menelusuri riwayat transaksi melalui antarmuka berbasis web.

### 1.4 Lingkungan Cloud dan Batasan

> _(Belum diisi — sebutkan provider yang dipakai: GCP / Digital Ocean / Azure / Local VM, beserta alasan singkat pemilihannya.)_

---

## 2. Rancangan Arsitektur Cloud

### 2.1 Diagram Arsitektur

> _(Belum diisi — sisipkan diagram dari draw.io yang menunjukkan: VM/instance backend, load balancer (jika ada), database server MongoDB, frontend server/CDN, dan komponen tambahan lain.)_

### 2.2 Spesifikasi dan Estimasi Biaya VM

> _(Belum diisi — buat tabel: Nama VM | Tipe/Spesifikasi (vCPU, RAM) | Fungsi | Harga/bulan, lalu totalkan biaya keseluruhan dan bandingkan dengan budget Rp1.300.000/bulan.)_

| VM | Spesifikasi | Fungsi | Harga/bulan |
|----|-------------|--------|-------------|
| | | | |
| **Total** | | | |

### 2.3 Justifikasi Pemilihan Arsitektur

> _(Belum diisi — jelaskan alasan pemilihan konfigurasi ini ditinjau dari sisi performa dan efisiensi biaya, misalnya alasan memisahkan database dari app server, jumlah instance backend, strategi load balancing, dsb.)_

---

## 3. Implementasi Teknis

### 3.1 Provisioning Infrastruktur

> _(Belum diisi — langkah-langkah pembuatan VM/instance, termasuk screenshot dashboard provider cloud.)_

### 3.2 Konfigurasi Backend (Flask + MongoDB)

> _(Belum diisi — langkah instalasi Python/Flask, konfigurasi koneksi ke MongoDB, konfigurasi Gunicorn/worker, dsb.)_

### 3.3 Konfigurasi Load Balancer / Reverse Proxy

> _(Belum diisi — jika menggunakan Nginx/load balancer, jelaskan konfigurasinya: round-robin, least connection, atau weighted.)_

### 3.4 Deployment Frontend

> _(Belum diisi — langkah deploy `index.html` dan `styles.css`, termasuk screenshot frontend yang sudah berjalan.)_

---

## 4. Pengujian Aplikasi

### 4.1 Pengujian Endpoint (Postman)

> _(Belum diisi — screenshot hasil request Postman untuk keempat endpoint: `POST /order`, `GET /order/<order_id>`, `GET /orders`, `PUT /order/<order_id>`.)_

### 4.2 Pengujian Antarmuka Frontend

> _(Belum diisi — screenshot antarmuka frontend saat membuat pesanan, melihat status, dan menelusuri riwayat transaksi.)_

---

## 5. Load Testing

Pengujian dilakukan menggunakan **Locust** (`Resources/Test/locustfile.py`), dijalankan dari host yang berbeda dari server aplikasi. Database dibersihkan dari data hasil insert setiap skenario agar tidak terjadi akumulasi data.

### 5.1 Skenario Pengujian

| No | Skenario | Parameter | Durasi |
|----|----------|-----------|--------|
| 1 | Maksimum RPS (0% failure) | Naikkan user secara bertahap | 60 detik |
| 2 | Peak Concurrency — Spawn Rate 50 | Tingkatkan user hingga failure muncul, catat nilai sebelumnya | 60 detik |
| 3 | Peak Concurrency — Spawn Rate 100 | Sama seperti di atas | 60 detik |
| 4 | Peak Concurrency — Spawn Rate 200 | Sama seperti di atas | 60 detik |
| 5 | Peak Concurrency — Spawn Rate 500 | Sama seperti di atas | 60 detik |

### 5.2 Hasil Skenario 1 — Maksimum RPS

> _(Belum diisi — catat rata-rata RPS tertinggi dengan tingkat kegagalan 0%, sertakan screenshot grafik RPS dari Locust.)_

### 5.3 Hasil Skenario 2–5 — Peak Concurrency

> _(Belum diisi — catat jumlah concurrent user tertinggi yang masih dapat dilayani dengan failure 0% untuk masing-masing spawn rate, sertakan screenshot grafik response time & failure rate.)_

| Skenario | Spawn Rate | Concurrent User Maksimum (failure 0%) |
|----------|-----------|----------------------------------------|
| 2 | 50 | |
| 3 | 100 | |
| 4 | 200 | |
| 5 | 500 | |

### 5.4 Monitoring Resource Utilization

> _(Belum diisi — sertakan screenshot CPU & memory usage server selama pengujian, misalnya dari `htop`/`vmstat`/monitoring provider cloud.)_

---

## 6. Kesimpulan dan Saran

### 6.1 Kesimpulan

> _(Belum diisi — ringkas hasil arsitektur, performa, dan efisiensi biaya yang dicapai.)_

### 6.2 Saran

> _(Belum diisi — rekomendasi untuk deployment nyata di masa depan, misalnya auto-scaling, caching, indexing tambahan, dsb.)_

---

## Lampiran: Struktur Repository

```
fp-tka-[nama-kelompok]/
├── README.md               ← Laporan utama
├── Resources/
│   ├── BE/
│   │   └── app.py          ← Backend Flask
│   ├── FE/
│   │   ├── index.html
│   │   └── styles.css
│   └── Test/
│       └── locustfile.py   ← Script load testing
└── result/
    ├── locust_rps.png
    ├── locust_concurrency_*.png
    └── cpu_usage_*.png
```
