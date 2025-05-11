# Kanban Board App

Aplikasi Kanban Board sederhana yang dibangun menggunakan Flutter. Aplikasi ini memungkinkan pengguna untuk mengelola tugas dalam format board Kanban dengan fitur drag-and-drop dan manajemen status.

## Fitur

- Tampilan board Kanban dengan kolom "Need to do", "On Process", dan "Finish"
- Manajemen item tugas dengan detail lengkap
- Sistem komentar untuk setiap item
- Penugasan PIC (Person In Charge)
- Perpindahan item antar status
- Tampilan detail item dengan informasi lengkap

## Persyaratan

- Flutter SDK (versi terbaru)
- Android Studio / VS Code
- Android Emulator atau perangkat fisik

## Cara Menjalankan

1. Clone repository ini
```bash
git clone [URL_REPOSITORY]
cd kanban-view
```

2. Install dependencies
```bash
flutter pub get
```

3. Menjalankan emulator Android
```bash
# Lihat daftar emulator yang tersedia
emulator -list-avds

# Jalankan emulator yang diinginkan (contoh: Pixel_2_API_25)
emulator -avd Pixel_2_API_25
```

4. Jalankan aplikasi
```bash
flutter run
```

## Perintah Flutter Run

Saat aplikasi berjalan, Anda dapat menggunakan perintah berikut:

- `r` - Hot reload (memperbarui UI tanpa me-restart aplikasi) 🔥
- `R` - Hot restart (me-restart aplikasi)
- `h` - Menampilkan daftar perintah yang tersedia
- `d` - Detach (menghentikan "flutter run" tapi aplikasi tetap berjalan)
- `c` - Membersihkan layar
- `q` - Quit (menghentikan aplikasi)

## Struktur Proyek

```
lib/
├── constants/
│   └── board_data.dart    # Data statis untuk board
├── models/
│   ├── board.dart         # Model untuk Board
│   └── item.dart          # Model untuk Item dan Comment
├── screens/
│   └── todo_board_page.dart  # Halaman utama Kanban
├── widgets/
│   └── todo_card.dart     # Widget untuk menampilkan item
└── main.dart              # Entry point aplikasi
```

## Pengembangan

Aplikasi ini menggunakan struktur yang modular dan clean code untuk memudahkan pengembangan lebih lanjut. Setiap komponen dipisahkan sesuai dengan fungsinya:

- `models/` - Berisi definisi data model
- `screens/` - Berisi halaman-halaman utama
- `widgets/` - Berisi komponen yang dapat digunakan kembali
- `constants/` - Berisi data statis dan konfigurasi

## Kontribusi

Silakan buat pull request untuk kontribusi. Untuk perubahan besar, harap buka issue terlebih dahulu untuk mendiskusikan perubahan yang diinginkan.
