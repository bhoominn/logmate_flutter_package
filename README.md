# 🪵 LogMate Flutter Package

**LogMate** is a Flutter package that helps developers track and monitor logs remotely from their apps. Logs are stored securely on a Supabase backend and can be viewed from a web dashboard in real-time. It's perfect for debugging, monitoring, or error reporting.

---

## ✨ What Does It Do?

- Allows you to send logs (like errors, warnings, debug info, etc.) from any Flutter app
- Helps you monitor logs remotely on a centralized web dashboard
- Offers filtering, severity levels, and secure app-level access
- Works without requiring user login in your app

---

## 🚀 How to Use LogMate

### ✅ Step 1: Register & Create App

- Visit the [LogMate Web Dashboard](https://logmate-flutter.web.app)
- Register and log in as a user
- Click **"Create New App"** to register your app
- Copy the **API_KEY** provided for your app – this will be used in your Flutter app

---

### 📦 Step 2: Install LogMate Package

In your Flutter app, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  logmate: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

### 🛠 Step 3: Initialize LogMate with API Key

In your app’s `main()` function or before you want to send any logs:

```dart
import 'package:logmate/logmate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await LogMate.initialize(appApiKey: 'YOUR_API_KEY_FROM_DASHBOARD');
  
  runApp(MyApp());
}
```

---

### 📝 Step 4: Send Logs from Anywhere in Your App. Using await is optional. It will return true if log was sent successfully, false otherwise.

Call `sendLog()` wherever you want to log something:

```dart
await LogMate.sendLog(
  title: 'Login Failed',
  description: 'Exception: No user found with given email.',
  severity: LogSeverity.error, // Choose from: debug, info, warning, error, critical
);
```

---

## 🧪 Example Use Cases

```dart
// For debug messages
await LogMate.sendLog(title: 'Debug Message', description: 'This is a debug log', severity: LogSeverity.debug);

// For warnings
await LogMate.sendLog(title: 'Slow Network', description: 'Network response > 5s', severity: LogSeverity.warning);

// For critical crashes
await LogMate.sendLog(title: 'Crash Report', description: 'App crashed on login screen', severity: LogSeverity.critical);
```

---

## 🔐 Security First

- Data is protected using Supabase's Row-Level Security (RLS)
- Only app owners (users who created the app) can view and manage logs via the dashboard

---

## 💻 Web Dashboard Features

- User registration & login
- Create multiple apps per user
- Get and manage unique API keys
- View logs with filtering (severity/date)

---

## 📄 License

MIT License

---

Made with ❤️ using Flutter & Supabase
