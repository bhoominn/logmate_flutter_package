import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';

/// Severity levels for logs
enum LogSeverity { info, warning, error, critical }

class LogMate {
  static final LogMate instance = LogMate._();

  LogMate._();

  late final SupabaseClient _client;
  late final String _apiKey;

  String deviceInfo = ''; //TODO add
  String appVersion = ''; //TODO add

  bool _isInitialized = false;

  Future<void> initialize({required String apiKey}) async {
    _apiKey = apiKey;
    _client = SupabaseClient(supabaseUrl, supabaseApiKey);
    _isInitialized = true;
  }

  Future<bool> sendLog({
    required String message,
    LogSeverity severity = LogSeverity.info,
    String? source,
    Map<String, dynamic>? customData,
  }) async {
    if (!_isInitialized) {
      throw Exception(
        "[LogMate] LogMate is not initialized. Call LogMate().initialize(...) first.",
      );
    }

    final result =
        await _client
            .from('apps')
            .select('id')
            .eq('api_key', _apiKey)
            .maybeSingle();

    print(result);
    if (result == null) {
      throw Exception('[LogMate] App not found.');
    }
    final appId = result['id'];
    final response = await _client.from('logs').insert({
      'app_id': appId,
      'message': message,
      'severity': severity.name,
      'source': source,
      'device_info': deviceInfo,
      'app_version': appVersion,
      'custom_data': customData,
    });

    if (response == null) {
      if (kDebugMode) print('[LogMate] Log sent successfully.');
      return true;
    } else {
      if (kDebugMode) print('[LogMate] Error while sending log: $response');
      return false;
    }
  }
}
