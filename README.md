# Tutorial 2

### Nama: Alvin Rheinaldy
### NPM: 2306275866

## Fitur Lanjutan

### 1. Double Jump

Pemain bisa melompat dua kali di udara.

**Implementasi:**
- Menggunakan variabel `jump_count` untuk melacak jumlah lompatan
- `jump_count` di-reset ke 0 saat `is_on_floor()` mendeteksi karakter menyentuh tanah
- Maksimal 2 lompatan (`max_jumps = 2`)

### 2. Double Tap Dash (i.e Terraria Ram Dash)

Pemain bisa meluncur cepat dengan menekan tombol arah dua kali.

**Implementasi:**
- Menggunakan `Time.get_ticks_msec()` untuk mencatat waktu tap
- Jika tombol yang sama ditekan dalam waktu < 0.25 detik (`DOUBLE_TAP_DELAY`), maka `start_dash()` dijalankan
- Karakter meluncur horizontal dengan `dash_speed = 600` selama `dash_duration = 0.15` detik

