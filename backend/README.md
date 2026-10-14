# backend/ — data + Firebase

Everything that isn't UI: the data models, the repository the app talks to, and the Firebase security rules. The app only goes through `LibraryRepository`, so I can swap the in-memory version for Firebase without touching any screens.

## What's here

```
lib/
  vault_backend.dart                    exports everything
  models/
    piece.dart                          one piece = one PDF
    score_set.dart                      a set = ordered list of piece IDs (no files)
  data/
    library_repository.dart             the interface the app uses
    in_memory_library_repository.dart   fake backend for building UI right now
firebase/
  firestore.rules                       draft: users can only touch their own data
  storage.rules                         draft: PDFs only, < 50 MB, owner only
```

## Data model

```
Firestore
  users/{uid}/pieces/{pieceId}  → title, composer, tags, pageCount, storagePath
  users/{uid}/sets/{setId}      → name, performanceDate, pieceIds: [ordered]

Cloud Storage
  users/{uid}/scores/{pieceId}.pdf   ← the ONE copy of each piece
```

The main rule is that a set never holds a file, only piece IDs. That's how a piece can be in 10 sets and still be 1 PDF. Deleting a piece also strips it out of every set so nothing points at a file that's gone.

## Next up

- `FirebaseLibraryRepository` (Auth + Firestore + Storage)
- Upload flow that writes the PDF once and creates the piece record (L-3)
- Offline caching per piece, not per set (O-3)
- Marketplace collections, way later (M-1 to M-5)
