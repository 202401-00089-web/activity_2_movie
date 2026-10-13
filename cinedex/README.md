# Cinedex 🎬 – Proposal

**Theme:** Movies
**API:** Studio Ghibli API – https://ghibliapi.vercel.app (free, JSON, no API key)

| Screen | Powered by | Endpoint | What it shows |
|---|---|---|---|
| Screen 1: Movie Library | FutureBuilder | `/films` | All Studio Ghibli movies (poster, year, director, runtime, Rotten Tomatoes score), fetched once |
| Screen 2: Now Showing | StreamBuilder | `/films/{id}` | A different random movie spotlight every 5 seconds |

## The 5 Elements (Atomic Design)

| Element | Screen 1: Movie Library | Screen 2: Now Showing |
|---|---|---|
| **Atoms** | `CineText`, `CineButton` (Retry), `LoadingSpinner`, `PosterImage`, `ScoreBadge` | `CineText`, `CineButton` (Retry), `LoadingSpinner`, `PosterImage`, `ScoreBadge`, `LiveBadge` |
| **Molecules** | `FilmTile` (poster + title + info + score), `LoadingMessage`, `StatusMessage` (error / empty) | `FilmCard` (banner + title + info + description), `LoadingMessage`, `StatusMessage` (error) |
| **Organisms** | `FilmList` (list of FilmTiles) | `FilmShowcase` (LiveBadge + FilmCard + counter) |
| **Templates** | `ScreenTemplate` (AppBar + body) | `ScreenTemplate` (AppBar + body) |
| **Pages** | `FilmListPage` | `NowShowingPage` (both inside `HomePage` with bottom navigation) |

## Folder Structure
```
lib/
├── main.dart                 app entry
├── models/                   film.dart  (fromJson)
├── services/                 film_api_service.dart  (status check + timeout)
├── atoms/                    cine_text, cine_button, loading_spinner, poster_image, score_badge, live_badge
├── molecules/                film_tile, film_card, loading_message, status_message
├── organisms/                film_list, film_showcase
├── templates/                screen_template
└── pages/                    home_page, film_list_page, now_showing_page
```

## Checklist
**Screen 1 (Future):** created once in `initState` · spinner · error + Retry · empty message · real API list · typed `Film` objects
**Screen 2 (Stream):** updates every 5 s (different movie each time) · loading state · error state · failed fetch uses `addError` so the stream keeps running · Retry · typed `Film` objects
**Both:** `fromJson` · status code check · 10 s timeout · no crash in airplane mode

## Airplane-mode test
1. Open Library, switch airplane mode on, tap Retry → error message (no crash). Turn it off → Retry → movies load.
2. Open Now Showing, switch airplane mode on → error state, no crash. Turn it off → a new movie appears on its own (or tap Retry).

## How to run
```
flutter create cinedex
# replace the new lib/ folder and pubspec.yaml with the ones in this project
flutter pub get
flutter run
```
Android release builds also need `<uses-permission android:name="android.permission.INTERNET"/>` in `android/app/src/main/AndroidManifest.xml`.
