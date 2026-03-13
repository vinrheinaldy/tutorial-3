# Tutorial 3

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

# Tutorial 5

### 1. Efek Suara Langkah Kaki

Karakter mengeluarkan suara langkah kaki yang sinkron dengan pijakan pada animasi berjalan.

**Implementasi:**
- Menggunakan signal `_on_animated_sprite_2d_frame_changed()` untuk mendeteksi *frame* animasi
- Memutar `footstep_sound` khusus pada *frame* 1 dan 3 saat karakter menyentuh tanah (`is_on_floor()`)
- Mengacak `pitch_scale` dengan `randf_range(0.8, 1.2)` agar suara langkah lebih natural dan bervariasi

### 2. BGM Fade Out Saat Jatuh

Volume *Background Music* (BGM) mengecil secara perlahan saat pemain jatuh keluar dari batas level.

**Implementasi:**
- Mendeteksi batas jatuh menggunakan variabel `fall_limit_y`
- Menghitung rasio seberapa jauh pemain jatuh dari batas tersebut menggunakan `clamp()`
- Menurunkan `volume_db` BGM secara halus menggunakan interpolasi linear (`lerp`) sesuai rasio jarak jatuh