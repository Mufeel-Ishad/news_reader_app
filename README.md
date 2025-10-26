# 📰 News Reader App

A Flutter-based mobile application that fetches real-time news articles from NewsAPI.org. The app offers a smooth reading experience, with offline access to saved favorites, category filtering, search functionality, and more.

---

## 📦 Project Description

This app allows users to:
- Browse top news headlines by category
- Search for articles by keyword
- View full article details with sharing and bookmarking options
- Save favorite articles for offline reading
- Enjoy a smooth and intuitive user interface

---

## ⚙️ Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Mufeel-Ishad/news_reader_app.git
   cd news_reader_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

> ✅ Android/iOS supported (not web, due to CORS limits on NewsAPI)

---

## 🔐 How to Get API Key

1. Go to [https://newsapi.org/register](https://newsapi.org/register)
2. Sign up for a free developer account
3. Copy your API key from the dashboard
4. Paste it into the `news_api_service.dart` file

---

## 🖼️ Screenshots

```
assets/screenshots/
```
```markdown
![Home Screen](assets/screenshots/home.png)
![Detail Screen](assets/screenshots/detail.png)
...
```

---

## ✅ Features Implemented

- [x] Home screen with top headlines
- [x] Pull-to-refresh functionality
- [x] Category tabs (Business, Sports, Tech, etc.)
- [x] Search screen with recent history
- [x] Article detail screen with:
  - Share article
  - Open in browser
  - Save/remove favorite
- [x] Offline access to saved favorites using SQLite
- [x] Swipe to delete favorites
- [x] Error handling with retry
- [x] Shimmer loading placeholders
- [x] Date formatting like “2 hours ago”
- [x] Theme mode toggle (System default supported)
- [x] Project structure follows best practices

---

## 🐞 Known Issues

- Some articles may have missing or broken image URLs
- No pagination currently (loads only first page of headlines/search)
- Web support not available due to CORS limitations in NewsAPI
- Fixed browser-opening issues

---

## 📌 Notes

- This project was built as part of a practical assessment
- Tested on Android real device (Samsung A01)

---

## 👤 Author

**Mufeel**  
Built with ❤️ using Flutter
