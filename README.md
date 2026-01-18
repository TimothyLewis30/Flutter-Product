# Flutter GetX Products App

Aplikasi mobile sederhana menggunakan Flutter dan GetX state management yang mengambil data dari DummyJSON API.

## Fitur

- ✅ **GET Products** - Menampilkan daftar produk dari API
- ✅ **Search Products** - Mencari produk berdasarkan keyword
- ✅ **Product Detail** - Melihat detail lengkap produk
- ✅ **POST Product** - Menambah produk baru ke API
- ✅ Pull-to-refresh functionality
- ✅ Error handling
- ✅ Loading states
- ✅ Material Design 3

## Teknologi

- **Flutter SDK** - Framework mobile
- **GetX** (v4.6.6) - State management & routing
- **HTTP** (v1.2.0) - REST API client
- **DummyJSON API** - Mock data source

## Cara Menjalankan

### 1. Install Flutter

Jika belum install Flutter, download dari:
https://docs.flutter.dev/get-started/install/windows

Pastikan Flutter sudah terdaftar di PATH system.

### 2. Verifikasi Instalasi

```bash
flutter doctor
```

### 3. Install Dependencies

```bash
cd "c:/Coding/Anti Gravity/flutter-getX"
flutter pub get
```

### 4. Jalankan Aplikasi

Untuk Android emulator atau device:
```bash
flutter run
```

Untuk Chrome (web):
```bash
flutter run -d chrome
```

Untuk Windows desktop:
```bash
flutter run -d windows
```

## Struktur Project

```
lib/
├── main.dart                    # Entry point aplikasi
├── models/
│   └── product_model.dart       # Model untuk Product
├── services/
│   └── api_service.dart         # API service layer (GET & POST)
├── controllers/
│   └── product_controller.dart  # GetX controller
├── views/
│   ├── product_list_view.dart   # Halaman daftar produk
│   ├── product_detail_view.dart # Halaman detail produk
│   └── add_product_view.dart    # Halaman tambah produk
└── routes/
    └── app_routes.dart          # Route constants
```

## API Endpoints

- **GET** `https://dummyjson.com/products` - Get all products
- **GET** `https://dummyjson.com/products/{id}` - Get single product
- **GET** `https://dummyjson.com/products/search?q={query}` - Search products
- **POST** `https://dummyjson.com/products/add` - Add new product

## Catatan

- API DummyJSON hanya simulasi, POST request tidak benar-benar menyimpan data ke server
- Produk yang ditambahkan akan muncul di list tetapi akan hilang saat refresh
- Aplikasi ini dibuat untuk demonstrasi Flutter + GetX integration
