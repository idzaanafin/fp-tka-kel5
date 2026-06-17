# FINAL PROJECT TEKNOLOGI KOMPUTASI AWAN 2026

### Kelas: A
|Nama|NRP|
|----|---|
|Ahmad Idza Anafin|5027241017|


## Permasalahan 
Anda adalah seorang lulusan Teknologi Informasi yang bekerja sebagai Cloud Engineer di sebuah perusahaan rintisan (startup) bidang e-commerce. Perusahaan tersebut sedang mengembangkan platform jual-beli online dan membutuhkan backend **Order Processing Service** — layanan inti yang menangani pembuatan pesanan, pengecekan status, dan riwayat transaksi.

Sebagai Cloud Engineer, Anda diminta untuk **mendeploy, mengonfigurasi, dan mengoptimalkan** layanan tersebut di atas infrastruktur cloud agar dapat menangani lonjakan traffic (flash sale, promo, dsb.) dengan andal dan efisien.

### Spesifikasi Aplikasi

Backend disediakan dalam bentuk REST API berbasis **Python (Flask)** dengan database **MongoDB**. Source code tersedia di folder `Resources/BE/app.py`.

#### Endpoints

**1. Create Order**

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

**2. Get Order Status**

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

**3. Get Order History**

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

**4. Update Order Status**

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

---

Selain backend, disediakan pula **Frontend** sederhana (`Resources/FE/index.html` dan `styles.css`) yang memungkinkan pengguna membuat pesanan, melihat status, dan menelusuri riwayat transaksi melalui antarmuka berbasis web.

---

Dengan **budget maksimal 1.3 juta rupiah per bulan (≈ 75 US$)**, rancang dan implementasikan arsitektur cloud terbaik yang mampu menerima request tertinggi dengan stabil

## Rancangan Arsitektur Cloud
## Implementasi Teknis
## Pengujian Aplikasi
## Load Testing 
## Kesimpulan dan Saran
