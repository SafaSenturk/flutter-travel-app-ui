<div align="center">

<img src="docs/banner.png" alt="GlobeGo – a Dribbble design rebuilt in Flutter" width="100%" />

# GlobeGo · Pixel-perfect Flutter UI

A Dribbble travel app design rebuilt **pixel by pixel** in Flutter, then turned into a working app: onboarding, destination browsing, favourites, a booking flow, a host chat and a Turkish / English interface.

[![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![State](https://img.shields.io/badge/state-Riverpod-0283D3)](https://riverpod.dev)
[![Design](https://img.shields.io/badge/design-Dribbble-EA4C89?logo=dribbble&logoColor=white)](https://dribbble.com/shots/27654880-Travel-Booking-App-Mobile-UI-UX-Design)
[![CI](https://github.com/SafaSenturk/flutter-travel-app-ui/actions/workflows/ci.yml/badge.svg)](https://github.com/SafaSenturk/flutter-travel-app-ui/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

**[⬇️ Download the APK](https://github.com/SafaSenturk/flutter-travel-app-ui/releases/latest)** · [🇹🇷 Türkçe açıklama](#-türkçe)

</div>

---

## Design vs Flutter

The original shot is **[Travel Booking App | Mobile UI/UX Design](https://dribbble.com/shots/27654880-Travel-Booking-App-Mobile-UI-UX-Design)** by **[Koushik Sarkar](https://dribbble.com/SARKAR07)**. The top row is the design, the bottom row is this app running on an Android emulator set to the same 393 × 852 pt screen.

<p align="center">
  <img src="docs/design_vs_flutter.jpg" alt="Dribbble design above, Flutter app below" width="820" />
</p>

<p align="center">
  <img src="docs/design_overlay.gif" alt="Each design screen cross-fading into the Flutter screen" width="560" /><br/>
  <sub>Each design screen fades into the app screen. Text, buttons and cards stay in place; only the photos change.</sub>
</p>

### How it was matched

1. **Measured, not eyeballed.** I downloaded the 3200 × 2400 shot, cut out the three phone screens, scaled them to the iPhone's 393 × 852 pt and drew a 10 pt grid on top. Every size, padding and radius in the code comes from that grid: 21 pt page margin, 42 pt header buttons, 51 pt region chips, 296 pt cards with a 30 pt radius, and a tab bar 74 pt tall above the home indicator.
2. **Colours sampled from pixels:** background `#F5F6F7`, ink `#080A23`, accent `#0283D3`, body text `#4A4C4E`.
3. **Typography fitted to the text.** The font is Outfit. Sizes come from cap heights; the tight letter spacing (about −3.5 %) comes from comparing text widths against the font's metrics.
4. **Same frame.** The design is drawn on an iPhone, so the layout keeps at least a 54 pt top and a 34 pt bottom inset. The emulator was set to `1080 × 2343 @ 440 dpi`, which is exactly 393 × 852 dp.
5. **Checked with scripts** (in [`tool/`](tool)):
   - `compare.py` overlays a screenshot on the design.
   - `measure.py` finds the ink bounding box of each text in both images.

Measured on the final build (pt, design → app):

| Element | Left edge | Top edge | Width |
|---|---|---|---|
| "Asia" chip label | 78.0 → 77.7 | 211.7 → 211.7 | 31.0 → 29.6 |
| Rating "5.0" | 72.3 → 72.3 | 301.0 → 300.7 | 22.7 → 21.7 |
| Search icon | 287.3 → 286.7 | 73.7 → 73.7 | 18.4 → 18.6 |
| Tab bar icons (row) | 141.3 → 142.0 | 766.3 → 766.3 | 195.0 → 195.0 |
| "Lake Como" title | 23.0 → 22.7 | 558.0 → 557.3 | 124.3 → 121.3 |
| "Ticket" chip content | 34.7 → 35.0 | 614.0 → 614.0 | 68.0 → 68.3 |
| Description, first line | 22.3 → 22.0 | 704.3 → 705.0 | 317.4 → 315.3 |
| "Continue" label | 50.3 → 51.7 | 775.3 → 775.3 | 65.0 → 64.0 |

What is different on purpose:
- **Photos.** The shot's images are not available, so the app uses free [Unsplash](https://unsplash.com/license) photos.
- **Status bar.** The status bar is Android's own.
- **Small fixes:**
  - "Scehedule" is spelled "Schedule".
  - The Lake Como screen shows a photo of Lake Como; the shot uses a Venice picture.

## Demo

<p align="center">
  <img src="docs/demo.gif" alt="Onboarding, filtering, opening a destination, adding extras and booking a trip" width="300" />
</p>

## Features

The design has three screens. Everything around them was designed in the same style and made to work:

- **Onboarding**
  - Story-style progress bars that advance on their own.
  - Ken Burns zoom on the photos; swipe between slides.
  - A real **slide-to-start** control: drag the "Continue" knob to the end, or tap it to go to the next slide.
- **Home**
  - Animated greeting.
  - Region chips filter the list (Asia / Europe / America).
  - Staggered card entrance.
  - Favourite hearts with a bounce.
  - Pulsing notification dot and a notifications sheet.
- **Destination detail**
  - Hero transition from the card.
  - Frosted-glass buttons.
  - Ticket / Hotel / Meal chips are real **add-ons**.
  - The overview expands on tap.
  - Share and favourite in the ⋮ menu.
- **Booking**
  - Pick a check-in day, nights and guests; the total counts up as you change them.
  - A confirmation dialog saves the trip to **My trips**, where you can cancel it.
- **Host chat:** quick questions with typing delay and replies, plus free text.
- **Discover:** a grid of all destinations with region and favourites filters.
- **Search:** works in both languages, so "Kapadokya" and "Cappadocia" both match.
- **Profile:** edit your name, see stats, switch language, replay the intro.
- **Turkish / English**, with every text in ARB files. Favourites, trips, name and language are saved on the device.

## Screenshots

| Intro | Last slide | Home | Region filter |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/01_intro.jpg" width="200"/> | <img src="docs/screenshots/02_intro_last.jpg" width="200"/> | <img src="docs/screenshots/03_home.jpg" width="200"/> | <img src="docs/screenshots/04_region_filter.jpg" width="200"/> |
| **Search** | **Detail** | **Add-ons + overview** | **Booking** |
| <img src="docs/screenshots/05_search.jpg" width="200"/> | <img src="docs/screenshots/06_detail.jpg" width="200"/> | <img src="docs/screenshots/07_extras.jpg" width="200"/> | <img src="docs/screenshots/08_booking.jpg" width="200"/> |
| **Confirmed** | **My trips** | **Discover** | **Favourites** |
| <img src="docs/screenshots/09_confirmed.jpg" width="200"/> | <img src="docs/screenshots/10_trips.jpg" width="200"/> | <img src="docs/screenshots/11_discover.jpg" width="200"/> | <img src="docs/screenshots/12_favorites.jpg" width="200"/> |
| **Host chat** | **Home (TR)** | **Detail (TR)** | **Profile (TR)** |
| <img src="docs/screenshots/13_chat.jpg" width="200"/> | <img src="docs/screenshots/14_home_tr.jpg" width="200"/> | <img src="docs/screenshots/15_detail_tr.jpg" width="200"/> | <img src="docs/screenshots/16_profile_tr.jpg" width="200"/> |

## Tech stack

| Area | Choice |
|---|---|
| UI | Flutter 3.44, Material 3, custom widgets only, `CustomPainter` for the tab bar's home icon, `BackdropFilter` glass |
| Animation | Hero with a shuttle that changes the corner radius, implicit animations, staggered reveals, `AnimationController` story bars and slide-to-start |
| State management | **Riverpod 3** (`Notifier` providers for locale, onboarding, favourites, region filter, bookings) |
| Storage | `shared_preferences` (JSON for bookings) |
| Localisation | `gen-l10n` ARB files, Turkish and English, `intl` dates |
| Assets | Outfit font (bundled), Hugeicons, Unsplash photos |
| Testing / CI | 14 unit and widget tests (pricing, search, persistence, onboarding flow, filters, Turkish UI), GitHub Actions |

## Project structure

```
lib/
├── main.dart                 # ProviderScope, MaterialApp, intro ↔ app switch
├── core/                     # theme tokens (colours, insets, type), shared widgets
├── data/destinations.dart    # 13 destinations in TR/EN, extras and pricing
├── state/providers.dart      # Riverpod notifiers + booking model
├── features/
│   ├── onboarding/           # story bars, slide-to-start
│   ├── shell/                # tab bar, drawer
│   ├── home/                 # header, region chips, destination cards, notifications
│   ├── detail/               # detail screen, booking sheet, host chat
│   ├── discover/  booking/  profile/  search/
└── l10n/
tool/                         # design comparison scripts (Python + Pillow)
```

## Run it yourself

```bash
git clone https://github.com/SafaSenturk/flutter-travel-app-ui.git
cd flutter-travel-app-ui
flutter pub get
flutter run
flutter test
```

No API keys or backend needed.

## Credits

- **UI design:** [Travel Booking App | Mobile UI/UX Design](https://dribbble.com/shots/27654880-Travel-Booking-App-Mobile-UI-UX-Design) by [Koushik Sarkar](https://dribbble.com/SARKAR07). The design images in `docs/` are shown only to compare against the original, and all rights to them stay with the designer.
- **Photos:** [Unsplash](https://unsplash.com) photographers, under the [Unsplash License](https://unsplash.com/license).
- **Font:** [Outfit](https://fonts.google.com/specimen/Outfit), SIL Open Font License.
- **Icons:** [Hugeicons](https://pub.dev/packages/hugeicons), MIT.

---

## 🇹🇷 Türkçe

**GlobeGo**, Dribbble'daki bir seyahat uygulaması tasarımının ([Koushik Sarkar](https://dribbble.com/SARKAR07)) Flutter ile **piksel piksel** yeniden yapılmış hâli. Yalnızca ekranları kopyalamakla kalmadım, çalışan bir uygulamaya dönüştürdüm.

**Tasarımı nasıl birebir yaptım?**
- Dribbble görselini 393 × 852 pt'lik iPhone ölçeğine indirip üstüne 10 pt'lik ızgara çizdim; bütün boşluk, boyut ve köşe yarıçapları bu ızgaradan ölçüldü.
- Renkleri piksellerden aldım.
- Fontu (Outfit) ve harf aralığını yazı genişliklerinden hesapladım.
- Emülatörü tam 393 × 852 dp'ye ayarladım.
- Ekran görüntüsünü tasarımın üstüne bindirip yazıların konumunu karşılaştıran Python betikleri yazdım (`tool/` klasöründe). Ölçülen farklar çoğunlukla 1–2 pt.

**Özellikler:**
- Hikâye çubuklu ve "kaydırarak başla" düğmeli tanıtım ekranı.
- Bölgeye göre filtreleme ve favoriler.
- Karttan detaya Hero geçişi.
- Bilet / Otel / Yemek ekstraları ve tarih, gece, kişi seçerek rezervasyon; Seyahatlerim'de iptal.
- Ev sahibiyle sohbet.
- Keşfet ızgarası ve iki dilde arama.
- Profil ve dil değiştirme.
- **Türkçe / İngilizce** arayüz; veriler cihazda saklanır.

**Denemek için:** [Releases](https://github.com/SafaSenturk/flutter-travel-app-ui/releases/latest) sayfasından APK'yı indir.

Elinde bir Figma ya da Dribbble tasarımı mı var? Onu birebir, animasyonlu ve çalışan bir Flutter uygulamasına dönüştürebilirim: **[safasenturk.github.io](https://safasenturk.github.io)**

---

<div align="center">

Built by **[Safa Şentürk](https://github.com/SafaSenturk)** · Flutter Mobile Developer · [Portfolio](https://safasenturk.github.io)

</div>
