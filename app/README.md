# app

The Flutter app (UI only). Gets its data from `../backend`.

## Files

- `lib/main.dart` - entry point
- `lib/app.dart` - app setup and theme
- `lib/screens/library_screen.dart` - list of scores
- `lib/screens/reader_screen.dart` - swipe reader, placeholder pages for now

## Running

```
flutter create --platforms=ios,android .
flutter pub get
flutter run
```

`android/` and `ios/` are generated so they're not in the repo.

## Todo

- Connect library screen to the repo (L-1)
- PDF import (L-3)
- Real PDF pages and tap to turn (R-1, R-4)
- Sets screen (S-1, S-2, S-4)
