import 'package:flutter_test/flutter_test.dart';
import 'package:logmate/logmate.dart';

void main() {
  const apiKey = '-';

  setUpAll(() async {
    LogMate.instance.initialize(apiKey: apiKey);
  });

  test('sendLog inserts a new log entry with correct data', () async {
    final message = 'Integration test log via API key';
    final severity = LogSeverity.error;
    final metadata = {'test_case': 'sendLog_with_apiKey', 'timestamp': DateTime.now().toIso8601String()};

    final success = await LogMate.instance.sendLog(message: message, severity: severity, customData: metadata);

    expect(success, isTrue);
  });
}
