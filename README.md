# Pokedex App

## Authors

* [@adedwi1808](https://www.github.com/adedwi1808)

---

## Installation

1. Clone repositori ini:

   ```bash
   git clone [<repo-url>](https://github.com/adedwi1808/Pokedex-UIKit.git)
   ```
2. Buka file `.xcodeproj` di Xcode.
3. Pastikan Swift Package Manager (SPM) mengunduh semua *dependency*:

   * Realm
   * RxSwift & RxCocoa
   * Alamofire
   * Kingfisher
   * XLPagerTabStrip
   * MBProgressHUD
4. Jalankan proyek (Build & Run).

---

## API Reference

Seluruh API menggunakan `baseURL`:

```
https://pokeapi.co/api/v2/
```

### Get Pokemon List

**Endpoint:**

```
GET /pokemon
```

| Parameter | Type   | Location    | Description                        |
| --------- | ------ | ----------- | ---------------------------------- |
| offset    | string | Query Param | Opsional. Offset untuk paginasi.   |
| limit     | string | Query Param | Opsional. Jumlah data per halaman. |

---

### Get Pokemon Detail

**Endpoint:**

```
GET /pokemon/{name_or_id}
```

| Parameter  | Type   | Location   | Description                          |
| ---------- | ------ | ---------- | ------------------------------------ |
| name_or_id | string | Path Param | Required. Nama atau ID dari Pokemon. |

---

## Tech Stack

**Client:**

* **UI:** UIKit
* **Arsitektur:** MVVM-C (Model-View-ViewModel-Coordinator)
* **Asynchronous:** RxSwift, RxCocoa
* **Networking:** Alamofire
* **Database:** RealmSwift (untuk caching offline & auth)
* **UI Layout:** SnapKit
* **Image Loading:** Kingfisher
* **UI Components:** XLPagerTabStrip, MBProgressHUD
* **Dependency Manager:** Swift Package Manager (SPM)
