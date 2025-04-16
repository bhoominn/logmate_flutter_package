import 'package:flutter/material.dart';
import 'package:logmate/logmate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize LogMate with your app's API key
  await LogMate.instance.initialize(apiKey: 'YOUR_API_KEY');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'LogMate Example', home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _sendTestLog() async {
    final success = await LogMate.instance.sendLog(
      message: "Test log message",
      severity: LogSeverity.info, //Optional
      source: "HomeScreen", //Optional
      customData: {'screen': 'home', 'action': 'tap'}, //Optional
    );

    if (success) {
      debugPrint("Log sent successfully.");
    } else {
      debugPrint("Failed to send log.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LogMate Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendTestLog,
          child: const Text("Send Log"),
        ),
      ),
    );
  }
}
