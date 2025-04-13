import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants.dart';

/// Severity levels for logs
enum LogSeverity { info, warning, error, critical }

/// A singleton class for integrating remote logging via Supabase.
///
/// The [LogMate] class allows you to initialize a logging system using an API key,
/// and send logs to server. Logs can include message, severity,
/// source, custom data, device info, and app version.
///
/// Usage:
/// ```dart
/// await LogMate.instance.initialize(apiKey: 'YOUR_API_KEY');
/// await LogMate.instance.sendLog(
///   message: 'Something went wrong',
///   severity: LogSeverity.error,
/// );
/// ```
class LogMate {
  /// Singleton instance
  static final LogMate instance = LogMate._();

  /// Private constructor for singleton pattern
  LogMate._();

  /// Supabase client to handle requests
  late final SupabaseClient _client;

  /// API key associated with the user's app, used to fetch `app_id`
  late final String _apiKey;

  /// Device info (to be implemented)
  String deviceInfo = ''; // TODO: Add device info dynamically

  /// App version (to be implemented)
  String appVersion = ''; // TODO: Fetch app version from package_info_plus

  /// Flag to check whether LogMate is initialized
  bool _isInitialized = false;

  /// Initializes LogMate with a required [apiKey]
  ///
  /// Must be called before using [sendLog] method.
  ///
  /// ```dart
  /// await LogMate.instance.initialize(apiKey: 'YOUR_API_KEY');
  /// ```
  Future<void> initialize({required String apiKey}) async {
    _apiKey = apiKey;
    _client = SupabaseClient(supabaseUrl, supabaseApiKey);
    _isInitialized = true;
  }

  /// Sends a log entry.
  ///
  /// Required:
  /// - [message]: Log message content
  ///
  /// Optional:
  /// - [severity]: Log severity level (`info`, `warning`, `error`, `critical`) (default: `info`)
  /// - [source]: Optional string to describe the log source (screen, feature, etc.)
  /// - [customData]: Any custom key-value data you want to associate with this log
  ///
  /// Returns `true` if log is sent successfully, `false` if an error occurs.
  ///
  /// Throws:
  /// - If `initialize()` wasn't called
  /// - If no app is found for the provided `apiKey`
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

    // Fetch the app ID based on the API key
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

    // Send log data to the logs table
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
