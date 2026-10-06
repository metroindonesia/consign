# fgta5framework

Basic setup untuk fgta5framework. Framework ini mengimplementasikan client core library **fgta5js**.

Untuk mempelajari lebih lanjut mengenai **fgta5js**, silakan merujuk ke:
- **Dokumentasi & Website**: [fgta5js.ferrine.com](https://fgta5js.ferrine.com/)
- **Source Code**: [GitHub - fgta5/fgta5js](https://github.com/fgta5/fgta5js)

## Setup Menggunakan degit

`degit` adalah alat yang mempermudah penyalinan repositori Git tanpa menyertakan riwayat git lama (git history). Ini sangat cocok digunakan untuk menginisialisasi proyek baru berdasarkan template ini.

### Prasyarat
Pastikan Anda sudah menginstal [Node.js](https://nodejs.org/) (Minimal versi 22).

### Cara Penggunaan

Jalankan perintah berikut di terminal Anda untuk membuat proyek baru menggunakan template ini:

```bash
npx degit fgta5/fgta5framework nama-project-anda
```

Setelah proses selesai, masuk ke direktori proyek baru Anda dan instal dependensi yang dibutuhkan:

```bash
cd nama-project-anda
npm install
```

Setelah instalasi selesai, jalankan script setup untuk mengonfigurasi database dan lingkungan proyek:

> **PERHATIAN:**
> Sebelum setup, pastikan service-service yang diperlukan (postgres, redis, dan notifierserver) telah di setup. Baca pada bagian setup docker jika diperlukan.


### Di Windows
```cmd
setup
```

### Di Linux / macOS
```bash
chmod +x setup
./setup
```
## Konfigurasi Environment File (.env)

Sebelum menjalankan container Docker atau menjalankan script setup, pastikan Anda telah menyalin dan mengonfigurasi file `.env` di root direktori proyek. File ini digunakan untuk mengatur parameter koneksi database, session, notifier server, dan konfigurasi port aplikasi.

Sesuaikan variabel berikut dengan kebutuhan lingkungan Anda:
- **Konfigurasi Database Utama (PostgreSQL)**: Sesuaikan parameter `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASS`, dan `DB_NAME`.
- **Konfigurasi Session & Redis**: Sesuaikan `REDIS_URL` untuk menghubungkan ke instance Redis Anda.
- **Notifier Server**: Konfigurasikan endpoint WebSocket (`NOTIFIER_SOCKET`) dan HTTP (`NOTIFIER_SERVER`).
- **Aplikasi**: Ubah port default aplikasi melalui `PORT` jika diperlukan.

## Setup Docker Network & Container (Jika diperlukan)

Setelah menjalankan setup framework di atas, Anda perlu menyiapkan environment Docker untuk database dan service pendukung (Postgres, Redis, Notifierserver, Minio).

### 1. Inisialisasi Docker Network
Masuk ke direktori `containers`:
```bash
cd containers
```

- **Di Windows**:
  Jalankan file `.bat` untuk membuat network Docker `docker1`:
  ```cmd
  setup-docker-network.bat
  ```

- **Di Linux / macOS**:
  Berikan izin eksekusi lalu jalankan script `.sh`:
  ```bash
  chmod +x setup-docker-network.sh
  ./setup-docker-network.sh
  ```

### 2. Menjalankan Docker Compose untuk Setiap Service
Setelah network dibuat, masuk ke masing-masing direktori service di dalam `containers/` dan jalankan `docker compose`:

- **Minio**:
  ```bash
  cd minio
  docker compose up -d
  cd ..
  ```

- **Notifier Server**:
  ```bash
  cd notifierserver
  docker compose up -d
  cd ..
  ```

- **PostgreSQL**:
  ```bash
  cd postgres
  docker compose up -d
  cd ..
  ```

- **Redis**:
  ```bash
  cd redis
  docker compose up -d
  cd ..
  ```


