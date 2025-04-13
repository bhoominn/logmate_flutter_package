# 🪵 LogMate Flutter Package

LogMate is a lightweight Flutter package that allows developers to send logs from their apps to a centralized server powered by Supabase. This helps in tracking errors and debugging apps remotely with ease.

## 🔧 Features

- Simple `initialize()` with just an `API_KEY`
- Send structured logs with various severity levels (`debug`, `info`, `warning`, `error`)
- View logs through a web dashboard

## 🚀 Getting Started

### 1. Install

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  logmate: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### 2. Initialize LogMate

Call `LogMate.initialize()` with your app’s API key:

```dart
import 'package:logmate/logmate.dart';

void main() async {
  await LogMate.initialize(appApiKey: 'YOUR_API_KEY');
  runApp(MyApp());
}
```

### 3. Send Logs

Use the `sendLog` method to log events:

```dart
await LogMate.sendLog(
  title: 'Something went wrong',
  description: 'Null pointer exception on login',
  severity: LogSeverity.error,
);
```

## 💻 Web Dashboard

- Access Free web dashboard here: https://logmate-flutter.web.app/
- Create apps and get API keys.
- View logs filtered by date/severity.
- Edit or delete apps.

## 📄 License

MIT License

---

Made with ❤️ using [Supabase](https://supabase.com) & Flutter.