# Reader Tracker (A.Reader) 📚

A modern Flutter application designed for book lovers to search, discover, save, and manage their personal reading library using the Google Books API and local SQLite storage.

---

## 🌟 Key Features

- **🔍 Book Search**: Search millions of volumes dynamically via the Google Books API with responsive grid results.
- **📖 Detailed View**: Inspect rich metadata including high-quality book covers, authors, publication dates, languages, and full summaries.
- **💾 Local Storage (Saved Books)**: Save books to a local SQLite database for quick access and offline availability.
- **❤️ Favorites Management**: Mark books as favorites and manage your collection across dedicated views.
- **📱 Intuitive Interface**: Seamless bottom navigation between **Home**, **Saved**, and **Favorites** screens with reactive UI state synchronization.

---

## 🛠️ Technologies & Packages Used

### **Core Framework & State Management**
- **[Flutter SDK](https://flutter.dev/) & [Dart](https://dart.dev/)**: Cross-platform UI toolkit and core programming language.
- **[Provider](https://pub.dev/packages/provider)** (`^6.1.5`): State management for reactive UI updates and clean separation of concerns (`BookProvider`).

### **Architecture & Networking**
- **Repository Pattern**: Clean architecture separating data fetching (`BookWebService`), data repository (`BookRepository`), and presentation layers.
- **[http](https://pub.dev/packages/http)** (`^1.6.0`): Asynchronous HTTP client for integrating with the **Google Books REST API**.

### **Database & Security**
- **[sqflite](https://pub.dev/packages/sqflite)** (`^2.4.2`): SQLite plugin for local persistent data storage.
- **[path](https://pub.dev/packages/path)** (`^1.9.1`): Cross-platform file path management for database initialization.
- **[envied](https://pub.dev/packages/envied)** (`^0.5.0`): Compile-time environment variable code generation for secure API key handling.

---

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AneesAhshawafi/reader_tracker.git
   cd reader_tracker
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate environment variables (if needed):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```
