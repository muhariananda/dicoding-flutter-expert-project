# a199-flutter-expert-project
[![Ditonton App Test CI](https://github.com/muhariananda/dicoding-flutter-expert-project/actions/workflows/cicd.yaml/badge.svg)](https://github.com/muhariananda/dicoding-flutter-expert-project/actions/workflows/cicd.yaml)

Repository ini merupakan starter project submission kelas Flutter Expert Dicoding Indonesia.



## Dokumentasi
---

### Perintah pada `makefile`
- Untuk menjalankan `flutter pub get` pada semua module :
```
    make get
```

- Untuk menjalankan `flutter pub upgrade` pada semua module :
```
    make upgrade
```

- Untuk menjalankan `flutter test` pada semua module :
```
    make test
```


### Struktur modular project
``` bash
    ├── lib
    │
    ├── features
    │   ├── about
    │   ├── movie_detail
    │   ├── movie_list
    │   ├── search
    │   ├── tv_series_detail
    │   ├── tv_series_list
    │   └── watchlist
    │
    └── packages
        ├── common
        ├── component_library
        ├── db_sqflite
        ├── http_ssl_pinning
        ├── monitoring
        ├── movie_core
        └── tv_series_core
```
Keterangan :
 - **features** : Folder untuk presentation layer
 - **packages** : Folder untuk packages yang dibutukan

