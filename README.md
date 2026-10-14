# Sheet Music Vault

Flutter, Dart, Firebase. Currently in progress (started Oct 2026).

A sheet music app for iOS and Android so musicians stop losing their music.

## Why

I've seen musicians in professional ensembles lose sheet music a lot. The part is on one device and not another, or there are multiple copies of the same piece in different folders and nobody knows which one is right. This app keeps everything in one library you can get to from any device you're signed into.

## Features (planned)

- Sign in and see your library on any device (starting with 50 scores)
- PDF reader where you swipe to turn pages like a book, page turns under 200 ms
- Sets for gigs and rehearsals. Sets just point to pieces, so each piece is only stored once no matter how many sets it's in
- Marketplace for original music later on

## Structure

- `app/` - Flutter UI
- `backend/` - models, data, Firebase rules

## Data

```
Firestore
  users/{uid}/pieces/{pieceId}  title, composer, tags, pageCount, storagePath
  users/{uid}/sets/{setId}      name, performanceDate, pieceIds

Storage
  users/{uid}/scores/{pieceId}.pdf
```

## Progress

- [x] Project setup, app and backend folders
- [x] Piece and set models
- [x] In memory repo to build UI before Firebase
- [x] Library screen and swipe reader (placeholder pages)
- [x] Draft Firebase rules
- [ ] Firebase setup and sign in
- [ ] PDF import and upload
- [ ] Real PDF rendering
- [ ] Test page turn speed
- [ ] Sets UI
- [ ] Offline sets
- [ ] Marketplace

## Running

Needs Flutter 3.22+.

```
cd app
flutter create --platforms=ios,android .
flutter pub get
flutter run
```

## User stories

Priority: P0 = MVP, P1 = after MVP, P2 = later

### Accounts

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| A-1 | As a musician, I want to sign up with email + password so that my library is tied to me and not one device. | P0 | Not started |
| A-2 | As a musician, I want to sign in with Apple or Google so that I don't have to make yet another password. | P1 | Not started |
| A-3 | As a musician, I want to stay signed in between launches so that I'm not logging in right before a downbeat. | P0 | Not started |
| A-4 | As a musician, I want to reset my password so that I can get back into my library if I forget it. | P0 | Not started |
| A-5 | As a musician, I want to delete my account and all my files so that I control my data. | P1 | Not started |

A-1 acceptance criteria:
- New user can create an account and lands on an empty library.
- Invalid email / weak password shows an inline error, no crash.
- User record is created at `users/{uid}`.

### Library

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| L-1 | As a musician, I want to see all my scores in one list so that I know what I have. | P0 | In progress |
| L-2 | As a musician, I want my library to hold at least 50 scores without slowing down so that my whole working repertoire fits. | P0 | Not started |
| L-3 | As a musician, I want to import a PDF from Files / Drive / email so that I can get my existing music in. | P0 | Not started |
| L-4 | As a musician, I want to add a title, composer, and tags to a score so that I can find it later. | P0 | Not started |
| L-5 | As a musician, I want to search by title or composer so that I can pull up a piece in seconds. | P0 | Not started |
| L-6 | As a musician, I want to filter by tag (e.g. "jazz", "wedding", "orch") so that I can narrow down a big library. | P1 | Not started |
| L-7 | As a musician, I want to rename or edit a score's info so that I can fix mistakes. | P0 | Not started |
| L-8 | As a musician, I want to delete a score so that I can clean up stuff I don't play anymore. | P0 | In progress |
| L-9 | As a musician, I want a warning if I try to import a PDF I already have so that I don't end up with duplicates. | P1 | Not started |

L-3 acceptance criteria:
- Only PDFs are accepted; anything else shows an error.
- File is uploaded once to `users/{uid}/scores/{pieceId}.pdf`.
- Page count is read and saved on the piece record.
- Upload progress is visible; failed uploads can be retried.

L-8 acceptance criteria:
- Deleting a piece removes the PDF from storage and the record from Firestore.
- The piece is removed from every set it was in (no dangling references).
- Confirmation dialog shows how many sets the piece is in.

### Reader

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| R-1 | As a musician, I want to open a score and see the actual PDF pages so that I can read it in the app. | P0 | In progress |
| R-2 | As a musician, I want to swipe left/right to turn pages like a book so that it feels natural on a stand. | P0 | In progress |
| R-3 | As a musician, I want page turns to happen in under 200 ms so that I never miss a beat waiting on the screen. | P0 | Not started |
| R-4 | As a musician, I want to tap the left/right edge to turn pages so that I can turn with one quick tap mid-phrase. | P0 | Not started |
| R-5 | As a musician, I want two pages side by side in landscape on a tablet so that I can see more music at once. | P1 | Not started |
| R-6 | As a musician, I want the screen to stay awake while reading so that it doesn't dim in the middle of a piece. | P0 | Not started |
| R-7 | As a musician, I want the score to reopen on the page I left it on so that I can pick up where I stopped practicing. | P1 | Not started |
| R-8 | As a musician, I want to pinch to zoom so that I can read tiny cue notes or dense passages. | P1 | Not started |
| R-9 | As a musician, I want to turn pages with a Bluetooth foot pedal so that my hands stay on my instrument. | P2 | Not started |

R-3 acceptance criteria:
- Measured from end of swipe gesture to next page fully drawn.
- p95 < 200 ms on a mid-range Android phone and an iPhone, 50-score library loaded.
- Adjacent pages are pre-rendered/cached so turns don't wait on decoding.
- Measured with Flutter DevTools timeline.

### Sets

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| S-1 | As a musician, I want to create a set (gig, rehearsal, concert) so that I can prep exactly what I need for a date. | P0 | In progress |
| S-2 | As a musician, I want to add pieces from my library to a set so that I can build a program. | P0 | In progress |
| S-3 | As a musician, I want the same piece in multiple sets without it being copied so that my storage doesn't blow up and edits stay in one place. | P0 | Done |
| S-4 | As a musician, I want to drag to reorder pieces in a set so that it matches the running order. | P0 | Not started |
| S-5 | As a musician, I want to swipe from the last page of one piece straight into the next piece in the set so that I can play a whole set without leaving the reader. | P1 | Not started |
| S-6 | As a musician, I want to remove a piece from a set without deleting it from my library so that I can change programs safely. | P0 | In progress |
| S-7 | As a musician, I want to give a set a date so that I can see upcoming gigs at the top. | P1 | Not started |
| S-8 | As a musician, I want to duplicate a set so that I can make a variation of a program quickly (still no file copies). | P2 | Not started |

S-3 acceptance criteria:
- A set stores an ordered list of piece IDs only - no file paths, no file data.
- Adding a piece to N sets results in exactly 1 file in storage.

### Sync & Offline

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| O-1 | As a musician, I want my library to show up on my phone and my tablet when I sign in so that I can use whichever device is on the stand. | P0 | Not started |
| O-2 | As a musician, I want changes on one device (new score, set edit) to show on my other devices automatically so that I'm never on an old version. | P0 | Not started |
| O-3 | As a musician, I want to download a set for offline use so that I can play venues with no signal. | P0 | Not started |
| O-4 | As a musician, I want to see which scores are on this device vs. cloud only so that I'm not surprised at the gig. | P1 | Not started |
| O-5 | As a musician, I want edits I make offline to sync when I'm back online so that I don't lose work. | P1 | Not started |

O-3 acceptance criteria:
- "Make available offline" on a set downloads every PDF in it.
- Opening an offline score with airplane mode on works and still hits R-3's page-turn target.
- Downloaded PDFs are cached per piece, not per set (still 1 copy on device).

### Marketplace (planned, post-MVP)

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| M-1 | As a composer, I want to publish an original piece so that other musicians can find and play it. | P2 | Not started |
| M-2 | As a musician, I want to browse original music by instrument, genre, and difficulty so that I can find new rep. | P2 | Not started |
| M-3 | As a musician, I want a piece I get from the marketplace to land straight in my library so that it works like any other score. | P2 | Not started |
| M-4 | As a composer, I want to set a price (or make it free) so that I can get paid for my work. | P2 | Not started |
| M-5 | As a composer, I want to see how many people added my piece so that I know what's landing. | P2 | Not started |

### Non-functional

- Builds for iOS and Android from one Flutter/Dart codebase - no platform-specific forks of features.
- Users can only read/write their own `users/{uid}/...` data (see `backend/firebase/`).
- Library list scrolls smoothly (60 fps) at 50+ scores.
- Usable in a dark pit: dark mode + adjustable brightness in the reader.
