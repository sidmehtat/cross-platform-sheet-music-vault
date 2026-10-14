# backend

Models, data, and Firebase rules. The app only talks to `LibraryRepository`, so I can switch from the in memory version to Firebase without changing the UI.

## Files

- `lib/models/piece.dart` - a piece, one pdf each
- `lib/models/score_set.dart` - a set, just a list of piece ids
- `lib/data/library_repository.dart` - what the app uses
- `lib/data/in_memory_library_repository.dart` - fake version for now
- `firebase/firestore.rules`, `firebase/storage.rules` - draft rules

## How sets work

Sets only store piece ids, never files. So a piece can be in 10 sets and there's still only 1 pdf. Deleting a piece removes it from all sets too.

## Todo

- Firebase repo (auth, firestore, storage)
- Upload flow (L-3)
- Offline caching (O-3)
- Marketplace (later)
