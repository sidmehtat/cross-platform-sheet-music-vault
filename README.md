# 🎼 Sheet Music Vault

**Flutter · Dart · Firebase** — 🚧 *actively in development (started Oct 2026)*

A sheet music PDF vault for working musicians, built for iOS and Android from one Flutter codebase.

## Why I'm building this

I've watched musicians in professional ensembles lose sheet music all the time. A part is on one iPad but not the other, a PDF got buried in someone's email, or there are 4 copies of the same chart across different gig folders and nobody knows which one has the right cuts marked. It's a dumb problem to have right before a downbeat.

So I'm building one library that follows you to any device you sign into. It opens scores fast and lets you turn pages like a real book. Each piece is stored **exactly once**, no matter how many sets it's in.

## What it's going to do

- **One library, every device.** Sign in on your phone or tablet and your scores are there (first target: 50 scores).
- **A reader built for playing.** Swipe or tap to turn pages, book style, and every page turn should finish in **under 200 ms**.
- **Sets without duplicates.** A set (gig, rehearsal, concert) just *references* pieces. Put the same piece in 10 sets and it's still 1 file.
- **Later: a marketplace** for original music, so composers can publish and musicians can find new rep.

## Repo layout

| Folder | What's in it |
|--------|--------------|
| [`app/`](app/) | The Flutter UI: screens, navigation, reader |
| [`backend/`](backend/) | Data models, repositories, Firebase security rules |

The app depends on the backend as a local package, so the UI never talks to Firebase directly.

## Progress

- [x] Repo split into `app/` (UI) and `backend/` (data)
- [x] Data models (`Piece`, `ScoreSet`) built around one file per piece
- [x] In-memory repository so I can build UI before Firebase is hooked up
- [x] Library screen + swipe reader (placeholder pages)
- [x] Draft Firestore + Storage security rules
- [ ] Firebase project + auth
- [ ] PDF import + upload
- [ ] Real PDF rendering in the reader (deciding between `pdfx` and `pdfrx`)
- [ ] Page-turn benchmarking (<200 ms target)
- [ ] Sets UI (create, reorder, play through)
- [ ] Offline sets
- [ ] Marketplace (way later)

## Running it

You'll need the [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.22+).

```bash
cd app
flutter create --platforms=ios,android --org com.sheetmusicvault .   # first time only
flutter pub get
flutter run
```

## User stories

This is the full backlog. IDs (like `R-3`) show up in TODOs and commits.

**Priority:** P0 = MVP, P1 = right after MVP, P2 = later
**Status:** ✅ done · 🚧 in progress · ⬜ not started

### Epic A — Accounts

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| A-1 | As a musician, I want to sign up with email + password so that my library is tied to me and not one device. | P0 | ⬜ |
| A-2 | As a musician, I want to sign in with Apple or Google so that I don't have to make yet another password. | P1 | ⬜ |
| A-3 | As a musician, I want to stay signed in between launches so that I'm not logging in right before a downbeat. | P0 | ⬜ |
| A-4 | As a musician, I want to reset my password so that I can get back into my library if I forget it. | P0 | ⬜ |
| A-5 | As a musician, I want to delete my account and all my files so that I control my data. | P1 | ⬜ |

**A-1 acceptance criteria**
- New user can create an account and lands on an empty library.
- Invalid email / weak password shows an inline error, no crash.
- User record is created at `users/{uid}`.

### Epic L — Library

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| L-1 | As a musician, I want to see all my scores in one list so that I know what I have. | P0 | 🚧 |
| L-2 | As a musician, I want my library to hold at least 50 scores without slowing down so that my whole working repertoire fits. | P0 | ⬜ |
| L-3 | As a musician, I want to import a PDF from Files / Drive / email so that I can get my existing music in. | P0 | ⬜ |
| L-4 | As a musician, I want to add a title, composer, and tags to a score so that I can find it later. | P0 | ⬜ |
| L-5 | As a musician, I want to search by title or composer so that I can pull up a piece in seconds. | P0 | ⬜ |
| L-6 | As a musician, I want to filter by tag (e.g. "jazz", "wedding", "orch") so that I can narrow down a big library. | P1 | ⬜ |
| L-7 | As a musician, I want to rename or edit a score's info so that I can fix mistakes. | P0 | ⬜ |
| L-8 | As a musician, I want to delete a score so that I can clean up stuff I don't play anymore. | P0 | 🚧 |
| L-9 | As a musician, I want a warning if I try to import a PDF I already have so that I don't end up with duplicates. | P1 | ⬜ |

**L-3 acceptance criteria**
- Only PDFs are accepted; anything else shows an error.
- File is uploaded once to `users/{uid}/scores/{pieceId}.pdf`.
- Page count is read and saved on the piece record.
- Upload progress is visible; failed uploads can be retried.

**L-8 acceptance criteria**
- Deleting a piece removes the PDF from storage and the record from Firestore.
- The piece is removed from every set it was in (no dangling references).
- Confirmation dialog shows how many sets the piece is in.

### Epic R — Reader

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| R-1 | As a musician, I want to open a score and see the actual PDF pages so that I can read it in the app. | P0 | 🚧 |
| R-2 | As a musician, I want to swipe left/right to turn pages like a book so that it feels natural on a stand. | P0 | 🚧 |
| R-3 | As a musician, I want page turns to happen in under 200 ms so that I never miss a beat waiting on the screen. | P0 | ⬜ |
| R-4 | As a musician, I want to tap the left/right edge to turn pages so that I can turn with one quick tap mid-phrase. | P0 | ⬜ |
| R-5 | As a musician, I want two pages side by side in landscape on a tablet so that I can see more music at once. | P1 | ⬜ |
| R-6 | As a musician, I want the screen to stay awake while reading so that it doesn't dim in the middle of a piece. | P0 | ⬜ |
| R-7 | As a musician, I want the score to reopen on the page I left it on so that I can pick up where I stopped practicing. | P1 | ⬜ |
| R-8 | As a musician, I want to pinch to zoom so that I can read tiny cue notes or dense passages. | P1 | ⬜ |
| R-9 | As a musician, I want to turn pages with a Bluetooth foot pedal so that my hands stay on my instrument. | P2 | ⬜ |

**R-3 acceptance criteria**
- Measured from end of swipe gesture to next page fully drawn.
- p95 < 200 ms on a mid-range Android phone and an iPhone, 50-score library loaded.
- Adjacent pages are pre-rendered/cached so turns don't wait on decoding.
- Measured with Flutter DevTools timeline.

### Epic S — Sets

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| S-1 | As a musician, I want to create a set (gig, rehearsal, concert) so that I can prep exactly what I need for a date. | P0 | 🚧 |
| S-2 | As a musician, I want to add pieces from my library to a set so that I can build a program. | P0 | 🚧 |
| S-3 | As a musician, I want the same piece in multiple sets without it being copied so that my storage doesn't blow up and edits stay in one place. | P0 | ✅ |
| S-4 | As a musician, I want to drag to reorder pieces in a set so that it matches the running order. | P0 | ⬜ |
| S-5 | As a musician, I want to swipe from the last page of one piece straight into the next piece in the set so that I can play a whole set without leaving the reader. | P1 | ⬜ |
| S-6 | As a musician, I want to remove a piece from a set without deleting it from my library so that I can change programs safely. | P0 | 🚧 |
| S-7 | As a musician, I want to give a set a date so that I can see upcoming gigs at the top. | P1 | ⬜ |
| S-8 | As a musician, I want to duplicate a set so that I can make a variation of a program quickly (still no file copies). | P2 | ⬜ |

**S-3 acceptance criteria**
- A set stores an ordered list of piece IDs only — no file paths, no file data.
- Adding a piece to N sets results in exactly 1 file in storage.

### Epic O — Sync & Offline

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| O-1 | As a musician, I want my library to show up on my phone and my tablet when I sign in so that I can use whichever device is on the stand. | P0 | ⬜ |
| O-2 | As a musician, I want changes on one device (new score, set edit) to show on my other devices automatically so that I'm never on an old version. | P0 | ⬜ |
| O-3 | As a musician, I want to download a set for offline use so that I can play venues with no signal. | P0 | ⬜ |
| O-4 | As a musician, I want to see which scores are on this device vs. cloud only so that I'm not surprised at the gig. | P1 | ⬜ |
| O-5 | As a musician, I want edits I make offline to sync when I'm back online so that I don't lose work. | P1 | ⬜ |

**O-3 acceptance criteria**
- "Make available offline" on a set downloads every PDF in it.
- Opening an offline score with airplane mode on works and still hits R-3's page-turn target.
- Downloaded PDFs are cached per piece, not per set (still 1 copy on device).

### Epic M — Marketplace (planned, post-MVP)

| ID | Story | Priority | Status |
|----|-------|----------|--------|
| M-1 | As a composer, I want to publish an original piece so that other musicians can find and play it. | P2 | ⬜ |
| M-2 | As a musician, I want to browse original music by instrument, genre, and difficulty so that I can find new rep. | P2 | ⬜ |
| M-3 | As a musician, I want a piece I get from the marketplace to land straight in my library so that it works like any other score. | P2 | ⬜ |
| M-4 | As a composer, I want to set a price (or make it free) so that I can get paid for my work. | P2 | ⬜ |
| M-5 | As a composer, I want to see how many people added my piece so that I know what's landing. | P2 | ⬜ |

### Non-functional

- Builds for iOS and Android from one Flutter/Dart codebase — no platform-specific forks of features.
- Users can only read/write their own `users/{uid}/...` data (see `backend/firebase/`).
- Library list scrolls smoothly (60 fps) at 50+ scores.
- Usable in a dark pit: dark mode + adjustable brightness in the reader.
