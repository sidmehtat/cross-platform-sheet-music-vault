# app/ — Flutter UI

This is the iOS + Android app. It's all UI: screens, navigation, and the reader. Data comes from [`../backend`](../backend), which this pulls in as a local package.

## What's here

```
lib/
  main.dart                 entry point (Firebase init goes here once it's set up)
  app.dart                  MaterialApp, theme (light + dark, dark matters in a pit)
  screens/
    library_screen.dart     list of scores, "Add score" button (import not wired yet)
    reader_screen.dart      swipe-to-turn reader, placeholder pages for now
```

## Run it

```bash
flutter create --platforms=ios,android --org com.sheetmusicvault .   # first time only
flutter pub get
flutter run
```

The `android/` and `ios/` folders are generated, so they're not committed.

## Next up

- Hook the library screen up to `LibraryRepository.watchPieces()` (L-1)
- PDF import (L-3)
- Real PDF pages in the reader + tap-edge page turns (R-1, R-4)
- Sets screen (S-1, S-2, S-4)
