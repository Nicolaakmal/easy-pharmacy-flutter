# Easy Pharmacy - Flutter Mobile App

Easy Pharmacy adalah platform farmasi online berbasis Mobile App yang memudahkan pengguna untuk:
- Melihat dan mencari berbagai jenis obat
- Menambahkan obat ke keranjang belanja
- Melakukan pemesanan obat
- Melacak status pesanan
- Mengelola profil pengguna

## Demo

<video src="assets/demo.mp4" controls width="360"></video>



## Teknologi dan Arsitektur

### Teknologi Utama
- **Flutter** - Framework UI untuk pengembangan aplikasi multi-platform
- **Dart** - Bahasa pemrograman
- **BLoC (Business Logic Component)** - State Management

### Arsitektur
Aplikasi ini dibangun menggunakan **Clean Architecture** yang membagi project menjadi tiga layer utama:

1. **Presentation Layer**
   - BLoC/Cubit
   - Screens
   - Widgets

2. **Domain Layer**
   - Entities
   - Repository Interfaces
   - Use Cases

3. **Data Layer**
   - Data Sources (Remote & Local)
   - Models
   - Repositories Implementation

Keuntungan penggunaan Clean Architecture:
- Pemisahan yang jelas antara business logic dan UI
- Testability yang lebih baik
- Maintenance yang lebih mudah
- Dependency rule yang jelas

## Fitur Aplikasi

### Registrasi dan Login
- Membuat akun baru
- Login dengan akun yang sudah ada
- Validasi form

### Homepage
- Tampilan obat-obat
- Pencarian obat
- Sorting obat
- Detail informasi obat

### Keranjang Belanja
- Menambahkan obat ke keranjang
- Mengubah kuantitas obat
- Menghapus obat dari keranjang
- Melihat total harga

### Pesanan
- Checkout dari keranjang
- Melihat status pesanan (unpaid, completed, canceled)
- Detail pesanan
- Penyelesaian pesanan
- Pembatalan pesanan

### Profil
- Melihat informasi profil
- Logout

## Instalasi dan Penggunaan

### Persyaratan
- Flutter SDK (versi terbaru)
- Dart SDK (versi terbaru)
- Android Studio / VS Code
- Emulator atau Perangkat Fisik (Android/iOS)

### Langkah Instalasi

1. Setup Backend Terlebih Dahulu
   
   > **PENTING**: Aplikasi mobile membutuhkan backend API untuk berfungsi dengan baik. Pastikan Anda telah menginstal dan menjalankan backend terlebih dahulu. Silakan ikuti instruksi instalasi yang tersedia di README repositori backend .......

2. Clone repositori frontend
   ```bash
   git clone https://github.com/YourUsername/easy-pharmacy-flutter.git
   cd easy-pharmacy-flutter
   ```

3. Install dependensi
   ```bash
   flutter pub get
   ```

4. Konfigurasi API endpoint
   
   Aplikasi ini sudah dikonfigurasi untuk terhubung ke backend dengan struktur endpoint berikut:
   
   ```dart
   const String _host = 'localhost';
   const int _port = 3000;
   
   /* ---------- base paths ---------- */
   const String _baseAuth = 'http://$_host:$_port/user';
   const String _baseDrug = 'http://$_host:$_port/drug';
   const String _baseCart = 'http://$_host:$_port/cart';
   const String _baseOrder = 'http://$_host:$_port/order';
   
   /* ---------- auth ---------- */
   const String registerEndpoint = '$_baseAuth/register';
   const String loginEndpoint = '$_baseAuth/login';
   
   /* ---------- drug ---------- */
   const String drugListEndpoint = '$_baseDrug/list';
   const String drugLengthEndpoint = '$_baseDrug/datalength';
   
   /* ---------- cart ---------- */
   const String addItemToCartEndpoint = '$_baseCart/add';
   const String getCartItemsEndpoint = '$_baseCart/list';
   const String updateCartItemQuantityEndpoint = '$_baseCart/updatequantity';
   const String deleteCartItemEndpoint = '$_baseCart/delete';
   
   /* ---------- order ---------- */
   const String checkoutOrderEndpoint = '$_baseOrder/placedorder';
   const String getOrderDetailsEndpoint = '$_baseOrder/detail';
   const String payOrderEndpoint = '$_baseOrder/paid';
   const String getUnpaidOrdersEndpoint = '$_baseOrder/unpaidlist';
   const String getPaidOrdersEndpoint = '$_baseOrder/paidlist';
   const String cancelOrderEndpoint = '$_baseOrder/cancel';
   const String getCancelledOrdersEndpoint = '$_baseOrder/cancellist';
   ```
   
   Jika Anda menjalankan server backend pada host atau port yang berbeda, pastikan untuk memperbarui variabel `_host` dan `_port` di file `lib/core/utils/constants.dart`.

5. Jalankan aplikasi
   ```bash
   flutter run
   ```

## Kontributor

- Nicola Akmal Afrinaldi - Frontend Mobile Developer (Flutter)




