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

### 🔹 App Screens (Grid View)

| Screenshot 1 | Screenshot 2 | Screenshot 3 |
|--------------|--------------|--------------|
| <img src="https://github.com/user-attachments/assets/e9a0aeb6-12f6-4815-abb1-08b0f236f56c" width="250" /> | <img src="https://github.com/user-attachments/assets/c79b3b2d-8779-476b-b19a-39df1822badd" width="250" /> | <img src="https://github.com/user-attachments/assets/5501fb5a-70a4-462d-a195-8e089ea60ea7" width="250" /> |

| Screenshot 4 | Screenshot 5 | Screenshot 6 |
|--------------|--------------|--------------|
| <img src="https://github.com/user-attachments/assets/5dea44c9-2527-4094-9c50-32b54c4fd827" width="250" /> | <img src="https://github.com/user-attachments/assets/cdbb736b-0521-4cec-bee7-439f6c3d6800" width="250" /> | <img src="https://github.com/user-attachments/assets/c39cfc05-9b6f-48ca-b0d1-a2bc7669bad5" width="250" /> |

### 🔹 Additional Screens

| Description        | Screenshot |
|--------------------|------------|
| Search Result       | <img src="https://github.com/user-attachments/assets/fa27cb19-51ff-43b4-a1c8-670d82670382" width="250" /> |
| Search Expanded     | <img src="https://github.com/user-attachments/assets/0741cf94-a4de-4268-ab5b-a21a21d2d4db" width="250" /> |
| Favorites Page      | <img src="https://github.com/user-attachments/assets/5946a8cc-a71c-4fdf-b579-1452bdfbcf69" width="250" /> |
| Article Details     | <img src="https://github.com/user-attachments/assets/7e8d607c-4b5b-498f-adb0-151a4e4a4a2f" width="250" /> |
| Open in Browser     | <img src="https://github.com/user-attachments/assets/ceb91f07-59ff-4b39-9b86-6322e99f8b62" width="250" /> |
| Share Article       | <img src="https://github.com/user-attachments/assets/a673f22b-349b-4d60-b87a-5e519f7c34cb" width="250" /> |
| Swipe to Delete     | <img src="https://github.com/user-attachments/assets/469f2907-fc96-4430-9798-445e1ffb237f" width="250" /> |
| Offline Favorites   | <img src="https://github.com/user-attachments/assets/e9522a61-91e3-4d0f-a63b-91d1dcd56897" width="250" /> |

---
## 🎥 Demo Video

Watch the full walkthrough of the app's features, UI, and performance in action:
- 👉 [Click here to watch the demo](https://supercut.ai/share/dome/0wLBxMReYzO1nDHbSWCNOI)

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
